//
//  UILabel+Extension.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/29.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

extension UILabel {
    
    // 遍历构造方法不能设置默认方法
    convenience init(color: UIColor, lines: Int) {
        
        self.init()
        textColor = color
        numberOfLines = lines
    }
}
