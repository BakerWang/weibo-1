//
//  UIImageView+Extension.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/29.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(imageName: String) {
        
        self.init()
        image = UIImage(named: imageName)
    }
}