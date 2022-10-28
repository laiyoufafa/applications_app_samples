/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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

import detailData from '../../../common/detailData'

export default {
  props: ['bannerdata'],
  data() {
    return {
      bannerData: detailData.goodsimgs,
      currIndex: 0,
      currentTime: 0,
    }
  },
  changeTabIndex(e) {
    this.currIndex = e.index;
    if (this.currIndex != 0) {
      this.$element('video').pause();
    } else {
      this.$element('video').start();
    }
  },
  onInit() {
    this.$on('smallVideoTime', this.getPassValue);
    this.$on('videoTime', this.setVideoTime)
  },
  getBigVideoTime(e) {
    this.currentTime = e.currenttime;
  },
  getPassValue() {
    this.$element('video').pause();
    this.$dispatch('receive', {
      params: this.currentTime
    })
  },
  setVideoTime(e) {
    this.$element('video').setCurrentTime({
      currenttime: e.detail.params,
    });
    this.$element('video').start();
  },
  playComplete() {
    this.$element('video').start();
  }
}