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

export default {
  data: {
    cartText: 'Add To Cart',
    cartStyle: 'cart-text',
    isCartEmpty: true,
    descriptionFirstParagraph: 'This is the merchandise page that includes some smartphone. \nYou can pick anything you like and add it to your cart. \nYour order will arrive within 72 hours. make sure our logistics arrive on time. \n Feel free to ask our 24-hour online service to learn more about our platforms and products.',
    imageList: ['/common/item_000.png', '/common/item_001.png', '/common/item_002.png', '/common/item_003.png'],
  },

  swipeToIndex(index) {
    this.$element('swiperImage').swipeTo({
      index: index
    });
  },


  addCart() {
    if (this.isCartEmpty) {
      this.cartText = 'Cart + 1';
      this.cartStyle = 'add-cart-text';
      this.isCartEmpty = false;
    }
  },

  getFocus() {
    if (this.isCartEmpty) {
      this.cartStyle = 'cart-text-focus';
    }
  },

  lostFocus() {
    if (this.isCartEmpty) {
      this.cartStyle = 'cart-text';
    }
  },
}