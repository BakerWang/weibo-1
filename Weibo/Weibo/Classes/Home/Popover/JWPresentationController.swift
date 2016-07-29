//
//  JWPresentationController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/29.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class JWPresentationController: UIPresentationController {

    // 动态修改展示视图的frame
    var presentedViewFrame: CGRect = CGRectZero
    /**
     第一个参数:presentingViewController -> 发起专场的对象
     第二个参数:presentedViewController -> 被展现的对象(在Xcode6中系统传入的是nil，在Xcode7中系统传入的是野指针)
     */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    /**
     containerView: 所有被展现的内容都放在containerView上
     presentedView: 通过该方法就可以拿到被展现的视图
     */
    override func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        // 添加蒙版
        containerView?.insertSubview(cover, atIndex: 0)
        // 设置蒙版frame
        cover.frame = containerView!.bounds
        
        // 默认frame为CGRectZero
        presentedView()?.frame = presentedViewFrame
    }
    
    // MARK: 内部控制方法
    @objc private func coverDismissClick() {
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - 懒加载
    private lazy var cover: UIButton = {
        
        let customView = UIButton()
        customView.backgroundColor = UIColor.clearColor()
        customView.addTarget(self, action: Selector("coverDismissClick"), forControlEvents: UIControlEvents.TouchUpInside)
        return customView
    }()
}













