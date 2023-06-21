/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import rdb from '@ohos.data.relationalStore';
import DataShareExtensionAbility from '@ohos.application.DataShareExtensionAbility'
import Logger from '../../common/Logger';

let DB_NAME = "DB00.db";
let TBL_NAME = "TBL00";
let DDL_TBL_CREATE = "CREATE TABLE IF NOT EXISTS "
+ TBL_NAME
+ " (city_id INTEGER PRIMARY KEY, city_name TEXT, city_temper INTEGER)";
let rdbStore;
const TAG = '[dataShare]';

export default class
extends DataShareExtensionAbility {
    async onCreate(want, callback) {
        Logger.info(`${TAG}`, `DataShareExtAbility onCreate this.context.databaseDir: ${this.context.databaseDir}`);
        // @ts-ignore
        rdbStore = await rdb.getRdbStore(this.context, { name: DB_NAME, securityLevel: rdb.SecurityLevel.S1 });
        Logger.info(`${TAG}`, `DataShareExtAbility getRdbStore done.`);
        await rdbStore.executeSql(DDL_TBL_CREATE, []);
        Logger.info(`${TAG}`, `DataShareExtAbility executeSql multiple tables done.`);
        let err = {"code":0};
        callback(err);
        let rdata = {
            "city_id": 310000,
            "city_name": "杭州"
        };
        let rdata2 = {
            "city_id": 110000,
            "city_name": "沈阳"
        };
        await rdbStore.insert(TBL_NAME, rdata, function (err, ret) {
            Logger.info(`${TAG}`, `[insert] callback ret: ${JSON.stringify(ret)}`);
        });
        await rdbStore.insert(TBL_NAME, rdata2, function (err, ret) {
            Logger.info(`${TAG}`, `[insert] callback ret: ${JSON.stringify(ret)}`);
        });
    }

    async update(uri, predicates, value, callback) {
        console.info('[ttt] [DataShareTest] <<Provider>> [update] enter');
        if (predicates == null || predicates == undefined) {
            console.info('[ttt] [DataShareTest] <<Provider>> [update] invalid predicates');
            return;
        };
        Logger.info(`${TAG}`, `[update]  values = ${value}`);
        Logger.info(`${TAG}`, `[update]  [update]  predicates = ${predicates}`);
        try {
            await rdbStore.update(TBL_NAME,value, predicates, function (err, ret) {
                Logger.info(`${TAG}`, `[update] callback ret: ${ret}`);
                Logger.info(`${TAG}`, `[update] callback err: ${err}`);
                if (callback != undefined) {
                    callback(err, ret);
                };
            });
        } catch (err) {
            Logger.error(`${TAG}`, `[update] error: ${err}`);
        }
        Logger.info(`${TAG}`, `[update] leave`);
    }
};