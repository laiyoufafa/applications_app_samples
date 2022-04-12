#  ArkUI-组件化

### 简介

本示例主要演示了自定义组件，包含数据的单双向传递及页面渲染，通过对@Component、@builder、@Extend、@BuilderParam使代码更加模块化，复用性更高，提升了代码的阅读效率。主界面由顶部轮播图组件、中部统计量组件、底部TabContent组件构成，当各个页面的数据发生变化时，其他组件的相关变量也随之发生变化，并及时刷新页面。

### 使用说明

1. 点击顶部轮播图中的**直播回顾**按钮或底部TabContent页面中ListItem中最左侧的**发布会视频封面**，则中部统计量组件中浏览量+1。
2. 点击顶部轮播图中的**直播预约**按钮或底部TabContent页面中ListItem的**预约**按钮，按钮图标会发生变化，顶部轮播图和底部TabContent相同数据的组件图标会发生联动效应，并且中部统计量组件中预约量+1。
3. 点击底部TabContent页面中ListItem的**收藏**按钮，则中部统计量组件中视频收藏量+1，并且底部TabContent组件中其它Content页面的数据也会同步刷新图标状态。

### 约束与限制

本示例仅支持在标准系统上运行。