//
//  ProfileTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class ProfileTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        
        if !login {
            
            vistorView?.setupVistorInfo("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
            return
        }
    }
}
