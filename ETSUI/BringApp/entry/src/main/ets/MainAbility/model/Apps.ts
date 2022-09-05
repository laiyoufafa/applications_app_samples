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

const Apps: Array<{
  img: Resource,
  info: string,
  name: Resource
}> =
  [
    {
      img: $r('app.media.camera'),
      info: 'camera',
      name: $r('app.string.camera')
    },
    {
      img: $r('app.media.gallery'),
      info: 'photos',
      name: $r('app.string.gallery')
    },
    {
      img: $r('app.media.contact'),
      info: 'contact',
      name: $r('app.string.contacts')
    },
    {
      img: $r('app.media.messages'),
      info: 'mms',
      name: $r('app.string.message')
    },
    {
      img: $r('app.media.clock'),
      info: 'clock',
      name: $r('app.string.clock')
    }
  ]

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []

  public totalCount() {
    return 0
  }

  public getData(index: number) {
    return undefined
  }

  registerDataChangeListener(listener: DataChangeListener) {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener) {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  notifyDataReload() {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  notifyDataAdd(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  notifyDataChange(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  notifyDataDelete(index: number) {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  notifyDataMove(from: number, to: number) {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }
}

export class MyDataSource extends BasicDataSource {
  private dataArray: any[] = Apps

  public totalCount() {
    return this.dataArray.length
  }

  public getData(index: number) {
    return this.dataArray[index]
  }

  public addData(index: number) {
    this.dataArray.splice(index, 0)
    this.notifyDataAdd(index)
  }

  public pushData(index: number) {
    this.dataArray.push()
    this.notifyDataAdd(this.dataArray.length - 1)
  }

  public deleteData() {
    this.dataArray.pop()
    this.notifyDataAdd(this.dataArray.length - 1)
  }
}