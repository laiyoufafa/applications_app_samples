# Settings 测试用例归档

## 用例表

|测试功能|预置条件|输入|预期输出|测试结果|
|---|---|---|---|---|
|拉起应用| 设备正常运行 |  |拉起Settings|Pass|
|窗口滑动| 应用已拉起 | 上滑窗口，检查页面是否正常滑动 |页面正常滑动，底部组件正常显示|Pass|
|WLAN模块| 位于首页 | 1.点击WLAN选项<br/>2.检查次级界面是否显示正常<br/>3.点击“更多WLAN设置”<br/>4.检查次级页面是否显示正常 |1.切换到次级界面<br/>2.次级界面内容正常显示<br/>3.切换到次级界面<br/>4.次级界面内容正常显示|Pass|
|更多连接模块| 位于首页 | 1.点击“更多连接”选项<br/>2.点击NFC选项<br/>3.检查次级页面显示是否正常 |1.切换到次级界面<br/>2.NFC选项显示正常，切换次级界面<br/>3.次级界面显示正常|Pass|
|窗口分屏| 应用已拉起 | 1.获取窗口Bounds信息，并触发分屏<br/>2.对比分屏前后Bounds信息 |1.窗口成功分屏<br/>2.分屏后bottom值小于分屏前|Pass|
|窗口化| 应用已拉起 | 1.获取窗口Bounds信息，并触发窗口化<br/>2.对比窗口化前后窗口大小<br/>3.像右上方拖动窗口<br/>4.对比拖动前后窗口Bounds信息 |1.应用成功窗口化<br/>2.窗口化后窗口长宽减小<br/>3.窗口正常拖动<br/>4.拖动后top，left值减小|Pass|
|窗口最小化| 应用已拉起 | 触发窗口最小化 |窗口最小化成功|Pass|
|窗口关闭| 应用已拉起 | 触发窗口关闭 |窗口关闭成功|Pass|