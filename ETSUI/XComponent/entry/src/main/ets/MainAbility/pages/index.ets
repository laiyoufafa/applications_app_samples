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

import nativerender from "libnativerender.so";
import { ContextType } from "../common/Constants"

const nativePageLifecycle = nativerender.getContext(ContextType.JSPAGE_LIFECYCLE);

@Entry
@Component
struct Index {
  private context = null;

  aboutToAppear() {
    console.log('[LIFECYCLE-Index] aboutToAppear');
    nativePageLifecycle.aboutToAppear();
  }

  aboutToDisappear() {
    console.log('[LIFECYCLE-Index] aboutToDisappear');
    nativePageLifecycle.aboutToDisappear();
  }

  onPageShow() {
    console.log('[LIFECYCLE-Page] onPageShow');
    nativePageLifecycle.onPageShow();
  }

  onPageHide() {
    console.log('[LIFECYCLE-Page] onPageHide');
    nativePageLifecycle.onPageHide();
  }

  build() {
    Flex({direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center}) {
      Button('ChangeColor')
        .key('changeColor')
        .onClick(() => {
          if (this.context) {
            this.context.changeColor();
          }
        })
        .width(200)
        .height(80)
        .flexShrink(0)
      Button('ChangeShape')
        .key('changeShape')
        .onClick(() => {
          if (this.context) {
            this.context.changeShape();
          }
        })
        .width(200)
        .height(80)
        .flexShrink(0)

      XComponent({ id: 'xcomponentId', type: 'texture', libraryname: 'nativerender' })
        .onLoad((context) => {
          this.context = context;
        })
        .onDestroy(() => {
        })
    }
    .width('100%')
    .height('100%')
  }
}
