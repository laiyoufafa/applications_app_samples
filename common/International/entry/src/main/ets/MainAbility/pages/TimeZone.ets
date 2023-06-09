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
import i18n from '@ohos.i18n'
import router from '@ohos.router'
import systemTime from '@ohos.systemTime'
import Logger from '../model/Logger'
import TitleBar from '../view/TitleBar'
class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []

  public totalCount(): number {
    return 0
  }

  public getData(index: number): any {
    return undefined
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdded(index)
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChanged(index)
    })
  }
}

class MyDataSource extends BasicDataSource {
  public dataArray: string[] = []

  constructor(ele) {
    super()
    for (var index = 0;index < ele.length; index++) {
      this.dataArray.push(ele[index])
    }
  }

  public totalCount(): number {
    return this.dataArray.length
  }

  public getData(index: number): any {
    return this.dataArray[index]
  }

  public addData(index: number, data: TimeZoneInfo): void {
    this.dataArray.splice(index, 0)
    this.notifyDataAdd(index)
  }
}

class TimeZoneInfo {
  key: string
  timeZone: string
  display: Resource
}

const TIME_ZONE_SRC: MyDataSource = new MyDataSource([
  { key: 'Asia/Shanghai', timeZone: 'GMT+08:00', display: $r('app.string.shanghai') },
  { key: 'America/New_York', timeZone: 'GMT-05:00', display: $r('app.string.new_york') }
])
const TAG: string = 'TimeZone'

@Entry
@Component
struct TimeZone {
  async setTimeZone(key) {
    let timeZone = await systemTime.getTimezone()
    if (timeZone === key) {
      router.back()
      return
    }
    let date = new Date()
    let currentZone = i18n.getTimeZone(timeZone)
    let targetZone = i18n.getTimeZone(key)
    let offsetTime = targetZone.getRawOffset() - currentZone.getRawOffset()
    Logger.info(TAG, `getOffsetDate getOffset: ${offsetTime}`)
    let time = date.getTime() + date.getTimezoneOffset() * 60 * 1000 + offsetTime
    Logger.info(TAG, `getOffsetDate time: ${time}`)
    await systemTime.setTime(time)
    await systemTime.setTimezone(key)
    Logger.info(TAG, `setTimezone, ${key}`)
    router.back()
  }

  build() {
    Column() {
      TitleBar({ hasBackPress: true, title: $r('app.string.time_zone') })
      Scroll() {
        Column() {
          LazyForEach(TIME_ZONE_SRC, (item, index) => {
            Column() {
              if (index !== 0) {
                Divider()
                  .color(Color.Gray)
                  .width('100%')
                  .strokeWidth(1)
                  .margin({ top: 10, bottom: 10 })
              }
              Text(item.display)
                .fontSize(22)
                .width('100%')
                .margin({ top: 10, bottom: 10 })
                .fontColor(Color.Black)
              Text(item.timeZone)
                .fontColor(Color.Gray)
                .fontSize(22)
                .width('100%')
                .margin({ top: 10, bottom: 10 })
            }
            .onClick(() => {
              this.setTimeZone(item.key)
            })
          }, item => item.key)
        }
        .width('95%')
        .padding(10)
        .margin({ top: 20, bottom: 10 })
        .backgroundColor(Color.White)
        .border({ color: Color.White, width: 1, radius: 15 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}