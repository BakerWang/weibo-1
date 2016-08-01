//
//  VistorView.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/28.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit
import SnapKit // masory

/**
什么时候用代理: 如果是父子关系 并且监听的方法较多 那么减一使用代理
什么时候用block: 如果是父子关系 并且只监听1~2个方法 那么可以使用block
什么时候通知: 层级结构较深
*/

class VistorView: UIView {
    
    // MARK: - 访客视图
    // 通过代码创建一个控件就会调用
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor(white: 235.0 / 255.0, alpha: 1.0)
        
        setupUI()
    }

    /**
    通过xib/sb 创建一个控件就会调用
    在Swift中, 为了简化业务逻辑, 默认情况下如果说自定义一个View
    那么建议要么自定义代码创建，要么自定义xib/sb创建
    */
    required init?(coder aDecoder: NSCoder) {
        
        // fatalError 致命错误(自定义代码和xib/sb同时有就会报错)
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - 外部控制方法
    func setupVistorInfo(imageName: String?, title: String) {
        
        self.title.text = title
        // 为空即首页
        guard let name = imageName else {
            
            startAnimation()
            return
        }
        icon.image = UIImage(named: name)
        homeIcon.hidden = true
    }
    
    // MARK: - 内部控制方法
    /**
    执行转盘旋转动画
    */
    private func startAnimation() {
        
        // 创建动画对象
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        animation.toValue = 2 * M_PI  // 旋转一圈
        animation.repeatCount = MAXFLOAT
        animation.duration = 8.0
        // 设置动画不自动移除
        animation.removedOnCompletion = false
        // 将动画添加到图层上
        homeIcon.layer.addAnimation(animation, forKey: nil)
    }
    
    // MARK: - 懒加载
    // 转盘
    private lazy var homeIcon: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_smallicon")
    // 图标
    private lazy var icon: UIImageView = UIImageView(imageName: "visitordiscover_feed_image_house")
    // 文本标签
    private lazy var title: UILabel = {
        
        let lb = UILabel(color: UIColor.lightGrayColor(), lines: 0)
        lb.text = "我说法是看见俺说你萨迦寺快递劫匪"
        return lb
    }()
    // 注册按钮
    lazy var registerButton: UIButton = {
        
        let btn = UIButton(title: "注册", titleColor: UIColor.orangeColor(), backImageName: "common_button_white_disable")
        return btn
    }()
    // 登录按钮
    lazy var loginButton: UIButton = {
        
        let btn = UIButton(title: "登录", titleColor: UIColor.darkGrayColor(), backImageName: "common_button_white_disable")
        return btn
    }()
    // 蒙版
    private lazy var maskImage: UIImageView = UIImageView(imageName: "visitordiscover_feed_mask_smallicon")
}

// MARK: - 布局UI
extension VistorView {
    
    /**
     初始化UI
     */
    private func setupUI() {
        
        // 添加子控件
        addSubview(homeIcon)
        addSubview(maskImage)
        addSubview(icon)
        addSubview(title)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 布局子控件
        homeIcon.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        icon.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(10)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(homeIcon.snp_bottom).offset(15)
            make.width.equalTo(225)
        }
        registerButton.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(title)
            make.top.equalTo(title.snp_bottom).offset(15)
            make.width.equalTo(100)
        }
        loginButton.snp_makeConstraints { (make) -> Void in
            
            make.right.equalTo(title)
            make.top.equalTo(title.snp_bottom).offset(15)
            make.width.equalTo(100)
        }
        maskImage.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(registerButton.snp_top)
        }
    }
}























