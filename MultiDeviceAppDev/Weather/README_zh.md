# 一多天气

### 介绍

本示例展示一个天气应用界面，包括首页、城市管理、添加城市、更新时间弹窗，体现一次开发，多端部署的能力。

实现：

1.本示例参考[一次开发，多端部署](https://gitee.com/openharmony/docs/tree/master/zh-cn/application-dev/key-features/multi-device-app-dev)的指导，主要使用响应式布局的栅格断点系统实现在不同尺寸窗口界面上不同的显示效果。

2.使用[SideBarContainer](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/arkui-ts/ts-container-sidebarcontainer.md)实现侧边栏功能。

3.本示例主要使用[栅格容器组件](https://gitee.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/arkui-ts/ts-container-gridrow.md)实现界面内容的分割和展示，其中对于设备类型和断点的对应关系如下：

| 水平宽度 (vp) | SizeType类型 | Columns数量 | 默认Margin | 默认Gutter | 典型设备                 |
| ------------- | ------------ | ----------- | ---------- | ---------- | ------------------------ |
| [0, 320)      | XS           | 2           | 12vp       | 12vp       | 智能穿戴                 |
| [320, 600)    | SM           | 4           | 24vp       | 24vp       | 默认设备                 |
| [600, 840)    | MD           | 8           | 32vp       | 24vp       | 智慧屏、竖屏状态的平板等 |
| [840, +∞)     | LG           | 12          | 48vp       | 24vp       | 车机、横屏状态的平板等   |

4.使用Canvas和CanvasRenderingContext2D完成空气质量和日出月落图的曲线绘制。

使用说明：

1.启动应用后，首页展示已添加城市的天气信息，默认展示2个城市，左右滑动可以切换城市，在LG设备上，默认显示侧边栏，侧边栏显示时，右侧内容区占2/3，侧边栏隐藏时，内容区自动铺满界面。

2.在支持窗口自由拖拽的设备上，拖拽窗口大小，可以分别实现拖动到最大窗口侧边栏显示（点击侧边栏控制按钮可以隐藏和显示侧边栏），拖动窗口缩小到MD大小时侧边栏和侧边栏控制按钮隐藏。

3.在支持窗口自由拖拽的设备上，拖拽窗口大小，天气内容区跟随窗口大小会自动换行显示。

4.点击右上角菜单按钮，在菜单中点击**更新时间**，弹出更新时间弹窗，没有功能，此处只做展示，在平板设备上显示2列，在小屏设备上显示一列。

5.点击右上角菜单按钮，在菜单中点击**管理城市**，进入管理城市界面，展示已添加的城市，在平板设备上显示2列，在小屏设备上显示一列。

6.点击管理城市界面的**添加城市**，进入添加城市界面，已添加的城市不可点击，未添加的城市点击可以添加并返回管理城市界面显示。

效果预览：

![home](./screenshots/devices/zh/home.png)

### 相关权限

不涉及。

### 依赖

不涉及。

###  约束与限制

1.本示例仅支持标准系统上运行。

2.本示例仅支持API9版本SDK，版本号：3.2.5.5 Beta2。

3.本示例需要使用DevEco Studio 3.0 Beta4 (Build Version: 3.0.0.992, built on July 14, 2022)才可编译运行。

