# SIM卡管理

### 简介

本示例展示了电话服务中SIM卡相关功能，包含SIM卡的服务提供商、ISO国家码、归属PLMN号信息，以及默认语音卡功能。效果图如下：

![](screenshots/devices/main.png)

### 相关概念

SIM管理:SIM卡相关功能。

### 相关权限

电话权限：ohos.permission.GET_TELEPHONY_STATE

### 使用说明

1.若SIM卡槽1插入SIM卡则SIM卡1区域显示为蓝色，否则默认为白色。

2.点击SIM卡1区域，弹窗显示SIM卡1的相关信息，再次点击面板消失。

3.默认拨号的SIM卡其按钮背景色为蓝色，目前只展示默认拨号的SIM卡，更改默认拨号卡功能暂不支持。

4.呼叫转移界面功能暂不支持，故点击按钮无实际操作。

### 约束与限制

1.本示例暂不支持双卡功能，且需要插入SIM卡，目前该功能仅支持部分机型。。

2.本示例仅支持在标准系统上运行。

3.本示例需要使用DevEco Studio 3.0 Beta4 (Build Version: 3.0.0.992, built on July 14, 2022)才可编译运行。

4.本示例所配置的权限ohos.permission.GET_TELEPHONY_STATE为system_basic级别(相关权限级别可通过[权限定义列表](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/security/permission-list.md)查看)，需要手动配置对应级别的权限签名(具体操作可查看[自动化签名方案](https://developer.harmonyos.com/cn/docs/documentation/doc-guides/ohos-auto-configuring-signature-information-0000001271659465))。
