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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("leftBarButtonItemDidClick"))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("rightBarButtonItemDidClick"))
    }
    
    @objc private func leftBarButtonItemDidClick() {
        
        NSLog("")
    }
    
    @objc private func rightBarButtonItemDidClick() {
        
        NSLog("")
    }
}
