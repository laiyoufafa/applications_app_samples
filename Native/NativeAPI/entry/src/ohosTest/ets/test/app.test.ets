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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import { UiDriver, BY, UiComponent, MatchPattern } from '@ohos.uitest'
import featureAbility from '@ohos.ability.featureAbility'
import hilog from '@ohos.hilog'

const TAG = '[Sample_NativeAPI]'
const DOMAIN = 0xF811
const BUNDLE = 'NativeAPI_'

export default function appTest() {
  describe('appTest', function () {
    it(BUNDLE + 'StartAbilityFunction_001', 0, async function (done) {
      hilog.info(DOMAIN, TAG, BUNDLE + 'StartAbilityFunction_001 begin')
      let parameter = {
        "want": {
          bundleName: "ohos.samples.nativeapi",
          abilityName: "ohos.samples.nativeapi.MainAbility"
        }
      }
      featureAbility.startAbility(parameter, (err, data) => {
        hilog.info(DOMAIN, TAG, BUNDLE + 'StartAbilityFunction_001,err.code:' + err.code)
        expect(0).assertEqual(err.code)
        done()
        hilog.info(DOMAIN, TAG, BUNDLE + 'StartAbilityFunction_001 end')
      })
    })
    /**
     * 点击开始游戏
     */
    it(BUNDLE + 'ClickStartFunction_001', 0, async function () {
      hilog.info(DOMAIN, TAG, BUNDLE + 'ClickStartFunction_001 begin')
      let driver = UiDriver.create()
      await driver.delayMs(1000)
      await driver.assertComponentExist(BY.key('startGame'))
      let startGame = await driver.findComponent(BY.key('startGame'))
      await driver.delayMs(1000)
      await startGame.click()
      hilog.info(DOMAIN, TAG, BUNDLE + 'ClickStartFunction_001 end')
    })
  })
}