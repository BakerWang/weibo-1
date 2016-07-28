//
//  UIBarButtonItem+Extension.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/29.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /**
     创建UIBarButtonItem
     
     - parameter imageName: item显示的图片
     - parameter target:    谁来监听
     - parameter action:    监听到之后执行的方法
     */
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        
        let btn = UIButton(imageName: imageName)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.init(customView: btn)
    }
}