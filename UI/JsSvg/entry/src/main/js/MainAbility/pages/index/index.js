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
import router from '@system.router';

export default {
    data: {
        title: ""
    },
    onInit() {
        this.title = this.$t('strings.world');
    },
    svgOnClick1() {
        router.push({uri:'pages/svg1/svg1'})
    },
    svgOnClick2() {
        router.push({uri:'pages/svg2/svg2'})
    },
    svgOnClick3() {
        router.push({uri:'pages/svg3/svg3'})
    },
    svgOnClick4() {
        router.push({uri:'pages/svg4/svg4'})
    }
}
