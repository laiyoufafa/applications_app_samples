/*
 * Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
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
const TAG = 'ResourceUtil';
import Logger from './Logger';

export default function getStringValue(id: number): string {
  let result = '';
  try {
    globalThis.abilityContext.resourceManager.getStringValue(id, (error, value) => {
      if (error !== null) {
        Logger.info(TAG, 'error is ' + error);
      } else {
        Logger.info(TAG, 'value is ' + value);
        result = value;
      }
    }
    );
  } catch (error) {
    Logger.info(TAG, `callback getStringValue failed, error code: ${error.code}, message: ${error.message}.`);
  }
  return result;
}
