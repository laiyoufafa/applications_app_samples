/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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

import Ability from '@ohos.app.ability.UIAbility'
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'
import { logger } from '@ohos/details-page-component'
import { notificationUtil } from '@ohos/notification'
import { QRCodeScanConst } from '@ohos/scan-component'

const TAG: string = 'MainAbility'
const PERMISSIONS: Array<string> = [
  'ohos.permission.CAMERA',
  'ohos.permission.MICROPHONE',
  'ohos.permission.READ_MEDIA',
  'ohos.permission.WRITE_MEDIA',
  'ohos.permission.MEDIA_LOCATION',
  'ohos.permission.INTERNET'
]

export default class MainAbility extends Ability {
  onCreate(want, launchParam) {
    logger.info(TAG, 'onCreate')
    const that = this
    this.context.eventHub.on("getAbilityData", (data) => {
      data.context = that.context
      data.launchWant = want
    })
    this.requestPermission()
    AppStorage.SetOrCreate('context', this.context)
  }

  requestPermission = async () => {
    let atManager = abilityAccessCtrl.createAtManager()
    try {
      atManager.requestPermissionsFromUser(this.context, [
        'ohos.permission.CAMERA',
        'ohos.permission.MICROPHONE',
        'ohos.permission.READ_MEDIA',
        'ohos.permission.WRITE_MEDIA',
        'ohos.permission.MEDIA_LOCATION',
        'ohos.permission.INTERNET'
      ]).then((data) => {
        // 如果权限列表中有-1，说明用户拒绝了授权
        if (data.authResults[0] === 0) {
          // 控制相机是否打开
          AppStorage.SetOrCreate(QRCodeScanConst.HAS_CAMERA_PERMISSION, true)
          logger.info('MainAbility permissionRequestResult success')
        }
      }, (err) => {
        logger.error(TAG, 'Request permission failed:' + JSON.stringify(err))
      })
    } catch (err) {
      logger.info(TAG, `catch err->${JSON.stringify(err)}`);
    }

    await notificationUtil.enableNotification()
  }

  onDestroy() {
    logger.info(TAG, 'onDestroy')
  }

  onWindowStageCreate(windowStage) {
    // Main window is created, set main page for this ability
    logger.info(TAG, 'onWindowStageCreate')

    windowStage.setUIContent(this.context, 'pages/Index', null)
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    logger.info(TAG, 'onWindowStageDestroy')
  }

  onForeground() {
    // Ability has brought to foreground
    logger.info(TAG, 'MainAbility onForeground')
    AppStorage.SetOrCreate('cameraStatus', !AppStorage.Get('cameraStatus'))
  }

  onBackground() {
    // Ability has back to background
    logger.info(TAG, 'onBackground')
  }
}