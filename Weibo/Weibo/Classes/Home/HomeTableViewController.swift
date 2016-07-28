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
    }
}
