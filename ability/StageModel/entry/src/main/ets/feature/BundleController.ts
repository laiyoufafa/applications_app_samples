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

import bundle from '@ohos.bundle'
import prompt from '@ohos.prompt'
import Logger from '../util/Logger'

const TAG: string = 'BundleController'

let bundleName = "com.example.myapplication"
let bundleFlags = 0
let userId = 100

export default class BundleController {

  // 获取有关当前应用程序的信息,对应FA模型的getApplicationInfo()
  getApplicationInfo() {
    bundle.getApplicationInfo(bundleName, bundleFlags, userId)
      .then((data) => {
        Logger.info(TAG, `getApplicationInfo successful. Data: ${JSON.stringify(data)}`)
        prompt.showToast({
          message: `getApplicationInfo successful`
        })
      }).catch((error) => {
      Logger.error(TAG, `getApplicationInfo. Cause: ${JSON.stringify(error)}`)
      prompt.showToast({
        message: `getApplicationInfo. Cause: ${JSON.stringify(error)}`
      })
    })
  }

  // 指示应用程序的实体类型,对应FA模型中AppContext的getAppType()
  entityType() {
    bundle.getApplicationInfo('ohos.samples.stagemodel', 0, (error, data) => {
      let digital = data.entityType
      if (digital === null || error) {
        Logger.info(TAG, `caller onRelease is error: ${error}`)
        return
      }
      Logger.info(TAG, `caller onRelease is called: ${digital}`)
      prompt.showToast({
        message: `caller onRelease is called sucess`
      })
    })
  }

  // 应用程序的进程，如果用户未设置，则值等于bundleName
  process() {
    bundle.getApplicationInfo('ohos.samples.stagemodel', 0, (error, data) => {
      let processData = data.process
      if (processData === null || error) {
        Logger.info(TAG, `caller onRelease is called error: ${error}`)
        return
      }
      Logger.info(TAG, `caller onRelease is called: ${processData}`)
      prompt.showToast({
        message: `caller onRelease is called sucess`
      })
    })
  }

  // 获取应用程序的本地根目录,对应FA模型的getOrCreateLocalDir()
  entryDir() {
    bundle.getApplicationInfo('ohos.samples.stagemodel', 0, (error, data) => {
      let entryDirData = data.entryDir
      if (entryDirData === null || error) {
        Logger.info(TAG, `codePath error: ${error}`)
        return
      }
      Logger.info(TAG, `codePath: ${entryDirData}`)
      prompt.showToast({
        message: `codePath: ${entryDirData}`
      })
    })
  }

  // 获取应用的版本信息,对应FA模型的getAppVersionInfo()
  getDispatcherVersion() {
    bundle.getDispatcherVersion()
    Logger.info(TAG, `getDispatcherVersion: ${JSON.stringify(bundle.getDispatcherVersion())}`)
    prompt.showToast({
      message: `getDispatcherVersion success`
    })
  }

  // 获取有关当前能力的信息,对应FA模型的getElementName()
  getAbilityInfo() {
    let bundleName = "ohos.samples.stagemodel"
    let abilityName = "TestAbility"
    bundle.getAbilityInfo(bundleName, abilityName)
      .then((data) => {
        Logger.info(TAG, `Operation successful. Data: ${JSON.stringify(data)}`)
        prompt.showToast({
          message: `Operation successful. Data: ${JSON.stringify(data)}`
        })
      }).catch((error) => {
      Logger.error(TAG, `Operation failed. Cause: ${JSON.stringify(error)}`)
      prompt.showToast({
        message: `Operation failed. Cause: ${JSON.stringify(error)}`
      })
    })
  }
}