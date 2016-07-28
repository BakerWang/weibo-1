//
//  MainViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: - 声明周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        // 初始化加号按钮
        setupComposeButton()
    }
    
    // MARK: - 监听点击事件(*)
    // 注意: 由于点击事件是由NSRunLoop发起的,并不是当前的类发起的, 所以如果在点击方法前面加上private 那么NSRunLoop无法找到该方法
    //
    // OC是基于运行时动态派发事件的, Swift是编译时就已经确定了方法
    // 如果想给监听点击的方法加上private, 并且又想让系统动态派发时找到这个方法，那么可以
    // 在private前面加上@objc, @objc在这个方法编译之前动态派发
    @objc private func composeBtnClick() {
        
        NSLog("composeBtnClick")
    }
    
    // MARK: - 懒加载
    private lazy var composeButton: UIButton = {
        
        // 1. 设置背景图片
        let btn = UIButton(imageName: "tabbar_compose_button", backImageName: "tabbar_compose_icon_add")
        // 监听Button点击
        btn.addTarget(self, action: Selector("composeBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
}

// MARK: - 内部控制器方法
// 初始化控制器
extension MainViewController {
    
    // 如果在方法前面加上private, 代表这个方法只能在当前文件中访问
    // 如果在属性前面加上private, 代表这个属性只能在当前文件中访问
    // 如果在类 前面加上private, 代表这个类只能在当前文件中访问
    private func setupComposeButton() {
        
        // 将加号按钮添加到tabbar上
        tabBar.addSubview(composeButton)
        // 计算宽度
        let width = UIScreen.mainScreen().bounds.width / CGFloat(childViewControllers.count)
        // 计算高度
        let height = tabBar.bounds.height
        // 修改frame
        let rect = CGRect(origin: CGPointZero, size: CGSize(width: width, height: height))
        composeButton.frame = CGRectOffset(rect, 2 * width, 0)
    }
    
    // 添加所有子控制器
    private func addChildViewControllers() {
        
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
            addChildViewController(NullViewController())
            addChildViewControllerWithJsonString("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewControllerWithJsonString("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    /**
     通过后台返回的字符串动态创建子控制器
     
     - parameter childControllerName: 子控制器名称
     - parameter title:               子控制器标题
     - parameter imageName:           子控制器图片
     */
    private func addChildViewControllerWithJsonString(childControllerName: String?, title: String?, imageName: String?) {
        
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
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        
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
