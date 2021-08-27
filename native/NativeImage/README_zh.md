# Native_image



### 简介

Native_image提供对像素数据和像素图信息的访问，本示例展示了如何声明JNI接口并通过JNI接口锁定和访问或解锁像素数据的函数。

### 使用说明

1、点击**获取Pixels**，获取给定**PixelMap**对象的内存地址并锁定内存，显示返回的调用结果。

2、点击**获取PixelMap信息**，返回PixelMap对象信息并显示。

3、点击**解锁Pixels**，显示返回的调用结果。

### 约束与限制

本示例仅支持在大型系统上运行。