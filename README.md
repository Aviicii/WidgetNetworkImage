# WidgetNetworkImage

# 3D Touch 快捷菜单 + 小组件显示网络图片 + CoreData缓存网络图片

==========================================================================================

#快捷菜单
1.优先级：动态->静态

(1)动态菜单：AppDelegate {

创建空数组items，创建所需的动态ShortcutItem，最后UIApplication.shared.shortcutItems = items

}
(2)静态菜单：Info.plist: UIApplicationShortcutItems：Array {

Icon Type      :系统图片
Title          :中文描述
Shortcut Item  :类型

}

2.根据不同类型跳转不同控制器（方法在AppDelegate）

==========================================================================================

#小组件
1.创建Target，选择小组件，使用SwiftUI绘制View，小组件不支持异步，所以只能同步加载网络图片
2.根据不同尺寸的组件点击进入不同控制器（方法在AppDelegate）

==========================================================================================

#CoreData
加载完网络图片，根据url进行保存Image的Data格式，显示小组件的时候优先使用CoreData本地图片数据，否则网络加载

### 1. PreView
![1.gif](1.gif)
