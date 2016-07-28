//
//  MessageTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        
        if !login {
            
            vistorView?.setupVistorInfo("visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
            return
        }
    }
}
