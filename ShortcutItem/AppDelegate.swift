//
//  AppDelegate.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window: UIWindow = UIWindow.init(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        
        var arr:[UIApplicationShortcutItem] = []
        let item:UIApplicationShortcutItem = .init(type: "dongtai", localizedTitle: "动态", localizedSubtitle: nil, icon: UIApplicationShortcutIcon.init(type: .add), userInfo: nil)
        arr.append(item)
        UIApplication.shared.shortcutItems = arr
        debugPrint(1)
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let vc:ViewController = ViewController()
        switch shortcutItem.type {
        case "haha":
            vc.color = .red
            break
        case "share":
            vc.color = .yellow
        default:
            vc.color = .blue
            break
        }
        window.rootViewController = vc
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let vc:ViewController = ViewController()
        switch url.path {
        case "small":
            vc.color = .red
            break
        case "medium":
            vc.color = .yellow
            break
        default:
            vc.color = .blue
            break
        }
        window.rootViewController = vc
        return true
    }
    
    
}

