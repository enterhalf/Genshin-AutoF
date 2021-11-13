# Genshin-AutoF
什么时候PC端才有一键拾取啊  
滚轮+F太累了  

### 用前须知
修改自b站火er丶:https://space.bilibili.com/12586633 的脚本，建议去支持一波  
1080P适用，若有问题需要自己修改判定点坐标，详细查看火er丶的视频：https://www.bilibili.com/video/BV1JA411s7Ud  
Old/原神-new.ahk是作者的源文件  

### 功能
自动拾取，自动点击传送点坐标

### 不同的版本
<b>main4-Gai</b>做了下判定点的修改，相比较原版速度变慢，但误触发NPC几率减小（有时候还是会触发） 建议用main4-Gai.ahk自己调试  
main5-Gai删了对多个物品的检测，更简单更快  
更多请直接看代码  

### 使用方法
#### 前置工作
将yuanshen.exe固定到开始菜单![110919882-b2cb6680-8357-11eb-9827-328b7d85d001](https://user-images.githubusercontent.com/49758022/111563720-74a8c980-87d3-11eb-8ec3-c91ffcc2a8d7.png)

#### 以.ahk运行
安装ahk：https://www.autohotkey.com/   

1、打开main.ahk(需要管理员权限才能正常使用)  
2、默认自动启动游戏以及自动拾取  
3、Capslock开启/关闭自动拾取，长按Capslock执行大写锁定，长按F10直接关闭游戏  
4、调试好后可以自己编译.exe

### 无法正常运行?
1、是否1080P，否的话需要自己手动修改判定点坐标  
2、是否右键以管理员模式启动   
