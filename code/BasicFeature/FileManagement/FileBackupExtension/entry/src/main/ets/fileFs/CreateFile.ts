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

import Logger from '../common/Logger';
import fs from '@ohos.file.fs';
import fileAccess from '@ohos.file.fileAccess';

export default class CreatFile {
   TAG: string = "[FileFS].[MyFile]";
   baseDir: string = globalThis.filesDir + '/TextDir';

  constructor() {
  }
  async  createTestFiles() {
    try {
      // let fileAccessHelper = fileAccess.createFileAccessHelper(globalThis.context);
      let num = Math.floor(Math.random() * 10) + 1;
      if (!fs.accessSync(this.baseDir)) {
        fs.mkdirSync(this.baseDir);
      }
      let dpath = this.baseDir;
      Logger.info(this.TAG, 'globalThis.filesDir = ' + dpath);
      Logger.info(this.TAG, 'num is  = ' + num);
      for (let i = 0; i < num; i++) {
        let myFile = dpath + `/TestFile_${i}.txt`;
        Logger.info(this.TAG, 'readyFile myFile = ' + myFile);
        let file = fs.openSync(myFile, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
        fs.writeSync(file.fd, new ArrayBuffer(1024 * Math.random()));
        fs.closeSync(file);
      }
    } catch (e) {
      Logger.error(this.TAG, 'Failed to prepare media files, error:' + e.message + e.code);
    }
  }
}