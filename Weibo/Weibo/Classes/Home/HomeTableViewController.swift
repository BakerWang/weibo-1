//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        
        if !login {
            
            vistorView?.setupVistorInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条
        setupNavigation()
    }
    
    /**
     初始化导航条
     */
    private func setupNavigation() {
        
        // 添加到导航栏左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("leftBarButtonItemDidClick"))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("rightBarButtonItemDidClick"))
        
        // 添加标题按钮
        let btn = JWTitleButton()
        btn.setTitle("EvenCoder", forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector("titleButtonDidClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = btn
    }
    
    @objc private func titleButtonDidClick(titleButton: JWTitleButton) {
    
        titleButton.selected = !titleButton.selected
        NSLog("")
    }
    
    @objc private func leftBarButtonItemDidClick() {
        
        NSLog("")
    }
    
    @objc private func rightBarButtonItemDidClick() {
        
        NSLog("")
    }
    
    /**
    *  
    */
}
