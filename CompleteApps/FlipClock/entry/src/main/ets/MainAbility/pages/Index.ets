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
import brightness from '@ohos.brightness'
import { Setting } from '../common/Setting'
import { CountDown } from '../common/CountDown'
import { FlipClock } from '../common/FlipClock'
import { AlarmClock } from '../common/AlarmClock'
import { MyDataSource } from '../common/DataSource'

AppStorage.Link('clockTime') || AppStorage.SetOrCreate('clockTime', [])

@Entry
@Component
struct Index {
  @State value: number = 128
  @State output: string = '熄屏'
  @State currentIndex: number = 0
  @State isComTime: boolean = true
  private tabScrollable: boolean = false
  private controller: TabsController = new TabsController()
  private array: any = [
    {
      icon: $r('app.media.worldclock'),
      icon_after: $r('app.media.worldclock_blue'),
      text: '时钟',
      num: 0
    },
    {
      icon: $r('app.media.clock'),
      icon_after: $r('app.media.clock_blue'),
      text: '闹钟',
      num: 1
    },
    {
      icon: $r('app.media.timer'),
      icon_after: $r('app.media.timer_blue'),
      text: '倒计时',
      num: 2
    },
    {
      icon: $r('app.media.settings'),
      icon_after: $r('app.media.settings_blue'),
      text: '设置',
      num: 3
    }
  ]
  private mainArray: MyDataSource = new MyDataSource(this.array)

  setBrightness() {
    brightness.setValue(this.value)
  }

  @Builder TabBuilder(item) {
    Column() {
      Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Image(this.currentIndex === item.num ? item.icon_after : item.icon)
          .flexGrow(1)
          .height(30)
          .width('30%')
          .objectFit(ImageFit.Contain)
          .opacity(this.currentIndex === item.num ? 1 : 0.5)
        Text(item.text)
          .flexGrow(1)
          .fontSize('20vp')
          .fontColor(this.currentIndex === item.num ? '#0A1EFF' : '#182431')
      }
      .width('200%')
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceBetween }) {
      Stack() {
        Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
          LazyForEach(this.mainArray, (item) => {
            TabContent() {
              if (item.text === '闹钟') {
                AlarmClock()
              } else if (item.text === '时钟') {
                FlipClock()
              } else if (item.text === '倒计时') {
                CountDown()
              } else if (item.text === '设置') {
                Setting()
              }
            }
            .tabBar(this.TabBuilder(item))
          })
        }
        .zIndex(-1)
        .width('100%')
        .height('100%')
        .vertical(false)
        .barMode(BarMode.Fixed)
        .animationDuration(370)
        .padding({ bottom: 10 })
        .backgroundColor('#F1F3F5')
        .scrollable(this.tabScrollable)
        .onChange((index: number) => {
          this.currentIndex = index
        })
      }
      .flexGrow(1)
      .zIndex(1)
      .width('100%')
      .height('100%')
    }
    .brightness(this.value)
    .gesture(SwipeGesture({ fingers: 1, direction: SwipeDirection.Vertical })
      .onAction((event: GestureEvent) => {
        if (0 <= event.angle) {
          this.value -= 20
          this.setBrightness()
        } else {
          this.value += 20
          this.setBrightness()
        }
        if (this.value > 255) {
          this.value = 0
          this.setBrightness()
        }
      })
    )
    .width('100%')
    .height('100%')
  }
}