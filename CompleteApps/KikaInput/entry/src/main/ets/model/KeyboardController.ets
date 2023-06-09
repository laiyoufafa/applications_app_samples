// @ts-nocheck
/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { GetHardKeyValue } from './HardKeyUtils.ets'
import inputMethodEngine from '@ohos.inputmethodengine'
import settings from '@ohos.settings';
import display from '@ohos.display'
import windowManager from '@ohos.window'
import featureAbility from '@ohos.ability.featureAbility'
import Log from './Log'

let InputMethodEngine = inputMethodEngine.getInputMethodEngine();
let isDebug = false;
let TAG: string = 'KeyboardController->';
export class KeyboardController {
  private readonly uri = 'dataability:///com.ohos.settingsdata.DataAbility'
  private helper: any = null
  private getValueRes: string = "1"
  private nonBarPosition: number = 0
  private barPosition: number = 0
  mContext
  WINDOW_TYPE_INPUT_METHOD_FLOAT= 2105
  windowName = 'imeWindow';
  isSpecialKeyPress = false;
  keySum = 0;
  isKeyboardShow = false;
  inputHandle= InputHandler.getInstance();
  mKeyboardDelegate;
  constructor(context) {
    this.inputHandle.addLog('constructor')
    this.mContext = context;
    this.helper = featureAbility.acquireDataAbilityHelper(this.mContext, this.uri)
  }

  public getValue(settingDataKey: string) {
    this.getValueRes = settings.getValueSync(this.helper, settingDataKey, "1")
  }

  public onCreate(): void {
    this.inputHandle.addLog('onCreate')
    this.initWindow();
    this.registerListener()
  }

  public onDestroy(): void {
    this.inputHandle.addLog('onDestroy')
    this.unRegisterListener();
    this.mContext.terminateSelf();
  }

  private initWindow(): void {
    this.inputHandle.addLog('initWindow')
    display.getDefaultDisplay().then(dis => {
      this.inputHandle.addLog("initWindow-oncall display");
      var dWidth = dis.width;
      var dHeight = dis.height;
      var navigationbar_height = 75;
      var keyHeightRate = 0.43;
      AppStorage.SetOrCreate<number>('windowWidth', dis.width)
      AppStorage.SetOrCreate<number>('windowHeight', dis.height)
      if (dWidth == 1080 && dHeight == 2376) {
        navigationbar_height = 105
        keyHeightRate = 35 / 99
      } else if(dWidth == 720 && dHeight == 1280) {
        navigationbar_height = 72
      } else if (dWidth == 2376 && dHeight == 1080) {
        navigationbar_height = 90
        keyHeightRate = 0.63
      }else if (dWidth == 2560 && dHeight == 1600) {
        navigationbar_height = 88
        keyHeightRate = 0.5
      }
      var keyHeight = dHeight * keyHeightRate;
      this.barPosition = dHeight - keyHeight - navigationbar_height
      this.nonBarPosition = dHeight - keyHeight
      this.inputHandle.addLog("initWindow-dWidth = " + dWidth + ";dHeight = " + dHeight + ";keyboard height = " + keyHeight + ";navibar height = " + navigationbar_height);

      this.inputHandle.addLog(typeof (this.mContext))
      this.inputHandle.addLog('initWindow-window = ' + typeof (windowManager))
      windowManager.create(this.mContext, this.windowName, this.WINDOW_TYPE_INPUT_METHOD_FLOAT).then((win) => {
        win.resetSize(dWidth, keyHeight).then(() => {
          win.moveTo(0, this.barPosition).then(() => {
            win.loadContent('pages/index').then(() => {
              this.inputHandle.addLog('loadContent finished')
            })
          })
        })
      })
    });
  }

  private resizeWindow() {
    this.inputHandle.addLog('resizeWindow');

    display.getDefaultDisplay().then(dis => {
      this.inputHandle.addLog("resizeWindow-oncall display");

      var dWidth = dis.width;
      var dHeight = dis.height;
      var navigationbar_height = dHeight * 0.07; //todo:有些产品导航栏高度为0，默认为0.07
      var keyHeightRate = 0.47;
      AppStorage.SetOrCreate<number>('windowWidth', dis.width)
      AppStorage.SetOrCreate<number>('windowHeight', dis.height)
      if (dWidth == 1080 && dHeight == 2376) {
        navigationbar_height = 105
        keyHeightRate = 35 / 99
      } else if(dWidth == 720 && dHeight == 1280) {
        navigationbar_height = 72
      } else if (dWidth == 2376 && dHeight == 1080) {
        navigationbar_height = 90
        keyHeightRate = 0.63
      }else if (dWidth == 2560 && dHeight == 1600) {
        navigationbar_height = 88
        keyHeightRate = 0.5
      }
      var keyHeight = dHeight * keyHeightRate;
      this.inputHandle.addLog("resizeWindow-dWidth = " + dWidth + ";dHeight = " + dHeight + ";keyboard height = " + keyHeight + ";navibar height = " + navigationbar_height);

      windowManager.find(this.windowName).then((win) => {
        win.resetSize(dWidth, keyHeight).then(() => {
          win.moveTo(0, dHeight - keyHeight - navigationbar_height).then(() => {
            this.inputHandle.addLog('resizeWindow-moveTo success');
          })

        })
      })
    });
  }

  private registerListener(): void {
    this.inputHandle.addLog('registerListener')

    display.on('change', (screenEvent) => {
      this.inputHandle.addLog('screenChangeEvent');
      this.resizeWindow()
    });
    InputMethodEngine.on('inputStart', (kbController, textInputClient) => {
      this.inputHandle.addLog('keyboard inputStart');
      this.inputHandle.onInputStart(kbController, textInputClient);
    })
    InputMethodEngine.on('inputStop', (imeId) => {
      this.inputHandle.addLog('keyboard inputStop: ' + JSON.stringify(imeId));
      if (imeId == "com.example.kikakeyboard/ServiceExtAbility") {
        this.onDestroy();
      }
    });
    InputMethodEngine.on('keyboardShow', () => {
      this.inputHandle.addLog('keyboard show');
      this.showWindow()
    });

    InputMethodEngine.on('keyboardHide', () => {
      this.inputHandle.addLog('keyboard hide');
      this.hideWindow();
    });

    this.mKeyboardDelegate = inputMethodEngine.createKeyboardDelegate();

    this.mKeyboardDelegate.on('keyDown', (keyEvent) => {
      this.inputHandle.addLog('OnKeyDown: code = ' + keyEvent.keyCode);

      if (this.isKeyboardShow) {
        this.inputHandle.hideKeyboardSelf();
      }

      if (this.isSpecialKeyPress) {
        this.keySum += 1;
        return false;
      }

      var keyCode = keyEvent.keyCode;

      var keyValue = GetHardKeyValue(keyCode);
      if (keyValue == "") {
        this.keySum += 1;
        this.inputHandle.addLog('OnKeyDown: unknown keyCode');
        this.isSpecialKeyPress = true;
        return false;
      }
      return true;
    });

    this.mKeyboardDelegate.on('keyUp', (keyEvent) => {
      this.inputHandle.addLog('OnKeyUp: code = ' + keyEvent.keyCode);
      var keyCode = keyEvent.keyCode;
      var keyValue = GetHardKeyValue(keyCode);

      if (this.isSpecialKeyPress) {
        if (this.keySum > 1) {
          this.isSpecialKeyPress = true;
        } else {
          this.isSpecialKeyPress = false
        }
        this.keySum -= 1;
        return false;
      }

      switch (keyValue) {
        case "KEYCODE_DPAD_UP":
        {
          inputMethodEngine.MoveCursor(inputMethodEngine.CURSOR_UP);
          if (isDebug) {
            this.inputHandle.refreshInfo();
          }
          break;
        }
        case "KEYCODE_DPAD_DOWN":
        {
          inputMethodEngine.MoveCursor(inputMethodEngine.CURSOR_DOWN);
          if (isDebug) {
            this.inputHandle.refreshInfo();
          }
          break;
        }
        case "KEYCODE_DPAD_LEFT":
        {
          inputMethodEngine.MoveCursor(inputMethodEngine.CURSOR_LEFT);
          if (isDebug) {
            this.inputHandle.refreshInfo();
          }
          break;
        }
        case "KEYCODE_DPAD_RIGHT":
        {
          inputMethodEngine.MoveCursor(inputMethodEngine.CURSOR_RIGHT);
          if (isDebug) {
            this.inputHandle.refreshInfo();
          }
          break;
        }
        case "KEYCODE_FORWARD_DEL":
        {
          this.inputHandle.deleteForward(1);
          break;
        }
        case "KEYCODE_DEL":
        {
          this.inputHandle.deleteBackward(1);
          break;
        }
        default:
          {
            this.inputHandle.insertText(keyValue);
            break;
          }
      }

      return true;
    });

    if (isDebug) {
      this.mKeyboardDelegate.on('cursorContextChange', (x, y, height) => {
        this.inputHandle.setCursorInfo('cursorInfo：(' + x + ',' + y + '), h = ' + height);
      });

      this.mKeyboardDelegate.on('selectionChange', (oldBegin, oldEnd, newBegin, newEnd) => {
        this.inputHandle.setSelectInfo('selectInfo: from(' + oldBegin + ',' + oldEnd + ') to (' + newBegin + ',' + newEnd + ')');
      });

      this.mKeyboardDelegate.on('textChange', (text) => {
        this.inputHandle.setTextInfo('textInfo: ' + text);
      });
    }
  }

  private unRegisterListener(): void{
    this.inputHandle.addLog('unRegisterListener')

    InputMethodEngine.off('inputStop');

    InputMethodEngine.off('keyboardShow');

    InputMethodEngine.off('keyboardHide');

    this.mKeyboardDelegate.off('keyDown');

    this.mKeyboardDelegate.off('keyUp');

    if (isDebug) {
      this.mKeyboardDelegate.off('cursorContextChange');

      this.mKeyboardDelegate.off('selectionChange');

      this.mKeyboardDelegate.off('textChange');
    }
  }

  private showWindow() {
    try {
      this.getValue('settings.display.navigationbar_status')
    } catch (err) {
      Log.showError(TAG, "get value failed" + err)
      return
    }
    Log.showInfo(TAG, 'current navigation state is' + this.getValueRes)
    this.inputHandle.addLog('showWindow');
    windowManager.find(this.windowName).then((win) => {
      win.show().then(() => {
        this.inputHandle.addLog('showWindow finish');
        this.isKeyboardShow = true;
      })
    })
  }

  private hideWindow() {
    this.inputHandle.addLog('hideWindow');
    windowManager.find(this.windowName).then((win) => {
      win.hide().then(() => {
        this.isKeyboardShow = false;
        this.inputHandle.addLog('hideWindow finish');
      })
    })
  }
}

export class InputHandler {
  private static instance: InputHandler;
  private mKbController;
  private mTextInputClient;
  private mEditorAttribute;
  private cursorInfo;
  private selectInfo;
  private textInfo;
  private inputInfo;
  private constructor() {

  }

  public static getInstance() {
    if (globalThis.instance == null) {
      globalThis.instance = new InputHandler();
    }
    return globalThis.instance;
  }

  public onInputStart(kbController, textInputClient) {
    globalThis.mKbController = kbController;
    globalThis.mTextInputClient = textInputClient;
    globalThis.mEditorAttribute = globalThis.mTextInputClient.getEditorAttribute();
    this.addLog("onInputStart mEditorAttribute = " + globalThis.mEditorAttribute);
    globalThis.mEditorAttribute.then(res => {
      globalThis.enterKeyType = res.enterKeyType;
      globalThis.inputPattern = res.inputPattern;
      this.setInputInfo("EditorInfo：enterKeyType = " + globalThis.enterKeyType + ";inputPattern = " + globalThis.inputPattern);
    })
  }

  public hideKeyboardSelf() {
    this.addLog('hideKeyboardSelf')
    globalThis.mKbController.hideKeyboard();
  }

  public sendKeyFunction() {
    this.addLog('sendKeyFunction')
    globalThis.mTextInputClient.sendKeyFunction(globalThis.enterKeyType);
  }

  public deleteBackward(length: number) {
    this.addLog('deleteBackward')
    globalThis.mTextInputClient.deleteBackward(length);
    if (isDebug) {
      this.refreshInfo();
    }
  }

  public deleteForward(length: number) {
    this.addLog('deleteForward')
    globalThis.mTextInputClient.deleteForward(length);
    if (isDebug) {
      this.refreshInfo();
    }
  }

  public insertText(text: string) {
    this.addLog('insertText')
    globalThis.mTextInputClient.insertText(text);
    if (isDebug) {
      this.refreshInfo();
    }
  }

  public addLog(message): void {
    Log.showInfo(TAG, "kikaInput-js: " + message)
  }

  public setCursorInfo(info) {
    globalThis.cursorInfo = info;
    this.addLog("setCursorInfo info = " + info);
  }

  public setSelectInfo(info) {
    globalThis.selectInfo = info;
    this.addLog("setSelectInfo info = " + info);
  }

  public setTextInfo(info) {
    globalThis.textInfo = info;
    this.addLog("setTextInfo info = " + info);
  }

  public setInputInfo(info) {
    globalThis.inputInfo = info;
    this.addLog("setInputInfo info = " + info);
  }

  public refreshInfo() {
    this.addLog('refreshInfo');
    var showText = '';
    this.addLog('refreshInfo1');
    showText += 'five chars: before：[' + globalThis.mTextInputClient.getForward(5) + '];after：[' + globalThis.mTextInputClient.getBackward(5) + ']\n';
    this.addLog('refreshInfo2');
    showText += globalThis.cursorInfo + "\n";
    this.addLog('refreshInfo3');
    showText += globalThis.selectInfo + "\n";
    this.addLog('refreshInfo4');
    showText += globalThis.textInfo + "\n";
    this.addLog('refreshInfo5');
    showText += globalThis.inputInfo;
    this.addLog('refreshInfo6');
    AppStorage.Set<string>('showLog', showText);
    this.addLog('refreshInfo7');
    this.addLog('result is = ' + showText);
  }
}