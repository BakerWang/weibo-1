//
//  MainViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        // 首页
//        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
//        // 消息
//        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
//        // 发现
//        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
//        // 我
//        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
        
        // 获取路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!
        let data = NSData(contentsOfFile: path)!
        
        /**
        在OC中处理异常是通过传入一个NSError的指针来保存错误
        Swift中提供专门处理异常机制 thows -> AnyObject
        Swift中提供try catch,将有可能发生错误的代码放到do中，如果真的发生了异常就会执行catch
        try作用: 如果抛出异常 那么就会执行catch
        try!作用: 告诉一定没有错误 不需要处理 但是如果使用try! 发生错误 那么程序就会崩溃 开发中不建议使用
        try?作用: 告诉系统可能有错也有可能没错 如果发生错误就会返回nil 如果没有错误就会包装成可选类型
        */
        do {
            // 服务器有数据进行创建
            let dictArr = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
            for dict in dictArr as! [[String: AnyObject]] {
                
                addChildViewControllerWithJsonString(dict["vcName"] as? String, title: dict["title"] as? String, imageName: dict["imageName"] as? String)
            }
        }catch {
            
            NSLog(error)
            // 服务器没有数据
            addChildViewControllerWithJsonString("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChildViewControllerWithJsonString("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            addChildViewControllerWithJsonString("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewControllerWithJsonString("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    // 通过后台返回的字符串动态创建子控制器
    func addChildViewControllerWithJsonString(childControllerName: String?, title: String?, imageName: String?) {
        
        /**
         guard使用:
         格式:
         guard 条件表达式 else {
         
            需要执行的语句
            return
         }
         特点: 只要条件为假才会执行else中的代码
         作用: 用于过滤数据
        */
         
        // 动态获取命名空间
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"]
        guard let name = nameSpace as? String else {
            
            print("命名空间不存在")
            return
        }
        
        guard let vcName = childControllerName else {
            
            NSLog("控制器名不能为nil")
            return
        }
        
        // 注意: 在Swift中，如果想通过字符串创建一个类 那么必须加上命名空间
        let cls: AnyClass? = NSClassFromString(name + "." + vcName)
        // 将AnyClass类型转换为UIViewController类型
        // AnyClass本质:AnyClass.Type 那么UIViewController本质:UIViewController.Type
        
        guard let clsType = cls as? UIViewController.Type else {
            
            print("控制器不存在")
            return
        }
        
        // 根据控制器类型创建一个子控制器
        let childVC = clsType.init()
        
        // 在iOS8之前只有文字有效果 图片没有效果
        tabBar.tintColor = UIColor.orangeColor()
        
        // 1.2 创建子控制器属性
        if let iName = imageName {
        
            childVC.tabBarItem.image = UIImage(named: iName)
            childVC.tabBarItem.selectedImage = UIImage(named: iName + "_highlighted")
        }
        // 系统由内向外设置标题
        childVC.title = title
        
        // 1.3 给子控制器包装导航控制器
        let naVC = UINavigationController(rootViewController: childVC)
        
        // 1.4 添加
        addChildViewController(naVC)

    }
    
    // 常规创建
    func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        
        // 1. 创建子控制器
        // 在iOS8之前只有文字有效果 图片没有效果
        tabBar.tintColor = UIColor.orangeColor()
        
        // 1.1 创建子控制器
        let childVC = childController
        
        // 1.2 创建子控制器属性
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        // childVC.tabBarItem.title = title
        // childVC.navigationItem.title = title
        // 系统由内向外设置标题
        childVC.title = title
        
        // 1.3 给子控制器包装导航控制器
        let naVC = UINavigationController(rootViewController: childVC)
        
        // 1.4 添加
        addChildViewController(naVC)
    }

}
