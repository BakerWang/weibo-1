//
//  AppDelegate.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/26.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

@UIApplicationMain

/**
项目分为开发阶段和发布阶段，开始阶段自动显示LOG, 发布阶段自己屏蔽LOG
开发阶段: 需要显示LOG
发布阶段: 不需要显示LOG

文件名称-方法名称[行号]: 输出内容
print(__FILE__) // 拿到当前文件路径
print(__LINE__) // 拿到当前的行号
print(__FUNCTION__) // 拿到当前的方法名称
*/

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // 1.创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // window?.backgroundColor = UIColor.orangeColor()
        
        // 2.创建跟控制器
        window?.rootViewController = MainViewController()
        
        // 3.显示控制器
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
       
    }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }
}

// <T>: 为泛型，外界传入什么就是什么
func NSLog<T>(message: T, file: NSString = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
    
    // Weibo -> BuildSetting -> Swift Compiler custom flag -> DEBUG(添加-D DEBUG)
    #if DEBUG
    print("\(method) \(line) \(message)")
    #endif
}








