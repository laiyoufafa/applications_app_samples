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

import dataShare from '@ohos.data.dataShare'
import dataSharePredicates from '@ohos.data.dataSharePredicates'
import prompt from '@ohos.prompt'
import Logger from '../util/Logger'

const TAG: string = 'DateShareHelper'
const BASE_URI = ('datashare:///ohos.samples.stagemodel.DataShare')
const COLUMNS = ['*']

class DataShareHelper {
  private dataShareHelper: any

  async getDataShareHelper(context) {
    // 对应FA模型FeatureAbilityTest中的acquireDataAbilityHelper
    this.dataShareHelper = await dataShare.createDataShareHelper(context, BASE_URI)
  }

  async insert() {
    Logger.info(TAG, `insert onClick`)

    if (this.dataShareHelper === null || this.dataShareHelper === undefined) {
      Logger.info(TAG, `insert dataShareHelper = ${this.dataShareHelper}`)
      return
    }
    let valuesBuckets = { name: 'Book name', introduction: 'Book introduction' }
    let insertId = await this.dataShareHelper.insert(BASE_URI, valuesBuckets)
    Logger.info(TAG, `insert succeed, data : ${insertId}`)
    let resultSet = await this.queryAll()
    return resultSet
  }

  async updateBook(book) {
    let predicates = new dataSharePredicates.DataSharePredicates()
    predicates.equalTo('id', book.id)
    let valuesBucket = {
      'name': book.name,
      'introduction': book.introduction
    }
    let num = await this.dataShareHelper.update(BASE_URI, predicates, valuesBucket)
    Logger.info(TAG + `update book num= ${num}`)
    let resultSet = await this.queryAll()
    return resultSet
  }

  async queryAll() {
    Logger.info(TAG, `queryAll start`)
    if (this.dataShareHelper === null || this.dataShareHelper === undefined) {
      Logger.info(TAG, `queryAll dataShareHelper = ${this.dataShareHelper}`)
      return
    }
    let predicates = new dataSharePredicates.DataSharePredicates()
    let resultSet = await this.dataShareHelper.query(BASE_URI, predicates, COLUMNS)
    Logger.info(TAG, `queryAll resultSet= ${JSON.stringify(resultSet)}`)
    return resultSet
  }

  // 删除指定数据
  async deleteBook(book) {
    Logger.info(TAG, `deleteBook start`)
    if (this.dataShareHelper === null || this.dataShareHelper === undefined) {
      Logger.info(TAG, `deleteBook dataShareHelper = ${this.dataShareHelper}`)
      return
    }
    let predicates = new dataSharePredicates.DataSharePredicates()
    predicates.equalTo('id', book.id)
    Logger.info(TAG, `delete id = ${book.id}`)
    let num = await this.dataShareHelper.delete(BASE_URI, predicates)
    await this.dataShareHelper.notifyChange(BASE_URI)
    Logger.info(TAG, `delete num= ${num}`)
    Logger.info(TAG, `delete queryAll start`)
    let resultSet = await this.queryAll()
    Logger.info(TAG, `delete queryAll end`)
    return resultSet
  }

  // 用户给定的URI转换为服务端使用的URI时回调此接口，该方法可以选择性重写。对应FA模型的DataAbilityHelper中的normalizeUri
  normalizeUri = () => {
    this.dataShareHelper.normalizeUri(BASE_URI, (error, data) => {
      if(error){
        Logger.info(TAG, `normalizeUri: ${error}`)
      }else{
        Logger.info(TAG, `normalizeUri: ${data}`)
        prompt.showToast({
          message: `normalizeUri sucess`
        })
      }
    })
  }

  // 服务端使用的URI转换为用户传入的初始URI时服务端回调此接口，该方法可以选择性重写。对应FA模型的DataAbilityHelper中的denormalizeUri
  denormalizeUri = () => {
    this.dataShareHelper.denormalizeUri(BASE_URI, (error, data) => {
      if(error){
        Logger.info(TAG, `denormalizeUri error: ${error}`)
      } else{
        Logger.info(TAG, `denormalizeUri: ${data}`)
        prompt.showToast({
          message: `denormalizeUri sucess`
        })
      }
    })
  }

  // 注册观察者以观察给定uri指定的数据。对应FA模型的DataAbilityHelper中的on
  on = async () => {
    Logger.info(TAG, `on start`)
    await this.dataShareHelper.on('dataChange', BASE_URI)
    Logger.info(TAG, `on end`)
      prompt.showToast({
        message: `on success`
    })
  }

  // 注销用于监视给定uri指定的数据的观察者。对应FA模型的DataAbilityHelper中的off
  off = async () => {
    Logger.info(TAG, `off start`)
    await this.dataShareHelper.off('dataChange', BASE_URI)
    Logger.info(TAG, `off end`)
      prompt.showToast({
        message: `off success`
    })
  }

  // 通知已注册的观察者Uri指定的数据资源的更改。对应FA模型的DataAbilityHelper中的notifyChange
  notifyChange = () => {
    this.dataShareHelper.notifyChange(BASE_URI, (error) => {
      if(error){
        Logger.info(TAG, `notifyChange error: ${error}`)
      }else{
        Logger.info(TAG, `notifyChange sucess`)
        prompt.showToast({
          message: `notifyChange sucess`
        })
      }
    })
  }
}

export default new DataShareHelper()