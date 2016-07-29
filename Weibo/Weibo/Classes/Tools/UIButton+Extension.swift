//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/28.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
    虽然一下方法可以快速创建一个UIButton对象，但是Swift风格不是这样写的
    在Swift开发中，如果想快速创建一个对象，那么可以提供一个便利构造器(便利构造器方法)
    只要在普通构造方法前面加上一个convenice, 那么这个构造方法就是一个便利构造方法
    注意: 如果定义一个便利构造器，那么必须在便利构造器中调用指定构造器(没有加convenice单词的构造方法)
    */
    class func createButton(imageName: String, backImageName: String) -> UIButton {
        
        // 1. 设置背景图片
        let btn = UIButton()
        // 设置背景图片
        btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        // 设置普通图片
        btn.setImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: backImageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return btn
    }
    
    convenience init(imageName: String, backImageName: String) {
        
        self.init()
        // 设置背景图片
        setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        // 设置普通图片
        setImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        setImage(UIImage(named: backImageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }
    
    convenience init(title: String, titleColor: UIColor, backImageName: String) {
        
        self.init()
        setTitle(title, forState: UIControlState.Normal)
        setTitleColor(titleColor, forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    convenience init(title: String, imageName: String,titleColor: UIColor) {
        
        self.init()
        setTitle(title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitleColor(titleColor, forState: UIControlState.Normal)
        sizeToFit()
    }
    
    convenience init(imageName: String) {
        
        self.init()
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        sizeToFit()
    }
}













