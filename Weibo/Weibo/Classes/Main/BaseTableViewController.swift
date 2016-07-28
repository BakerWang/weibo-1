//
//  BaseTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/28.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // 定义标记，记录用户当前是否登录
    var login: Bool = true
    // 访客视图
    var vistorView: VistorView?
    override func loadView() {
        
        login ? super.loadView() : setupVistorView()
    }
    
    /**
    初始化未登录界面
    */
    private func setupVistorView() {
        
        // 创建访客视图
        vistorView = VistorView()
        view = vistorView // 自定义UIView
        // 监听访客视图按钮的点击
        vistorView?.registerButton.addTarget(self, action: Selector("registerDidClick"), forControlEvents: UIControlEvents.TouchUpInside)
        vistorView?.loginButton.addTarget(self, action: Selector("loginDidClick"), forControlEvents: UIControlEvents.TouchUpInside)
        // 添加导航条注册登录按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("registerDidClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("loginDidClick"))
    }
    
    @objc private func registerDidClick() {
        
        NSLog("registerDidClick")
    }
    
    @objc private func loginDidClick() {
        
        NSLog("loginDidClick")
    }
}
