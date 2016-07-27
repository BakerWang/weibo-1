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

        // 首页
        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        
        // 消息
        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
        
        // 发现
        addChildViewController(DiscoverTableViewController(), title: "发现", imageName: "tabbar_discover")
        
        // 我
        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    }

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
