//
//  DiscoverTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        
        if !login {
            
            vistorView?.setupVistorInfo("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
            return
        }
    }
}
