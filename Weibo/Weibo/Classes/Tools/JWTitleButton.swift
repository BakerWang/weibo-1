//
//  JWTitleButton.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/29.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class JWTitleButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        adjustsImageWhenHighlighted = false  // 阻止点击变色
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 自定义按钮调整布局
    override func layoutSubviews() {
        
        super.layoutSubviews()
        // 注意: 下面代码在OC写法是不对的 但在Swift是可以的
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.bounds.width
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        
        if let t = title {
            
            super.setTitle(t + "  ", forState: UIControlState.Normal)
        }
    }

//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        return CGRectZero
//    }
//    
//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        return CGRectZero
//    }
}
