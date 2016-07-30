//
//  HomeTableViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/27.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    // MARK: - 生命周期方法
    override func viewDidLoad() {
        
        if !login {
            
            vistorView?.setupVistorInfo(nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条
        setupNavigation()
    }
    
    // 移除通知
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // MARK: - 内部控制方法

    // 初始化导航条
    private func setupNavigation() {
        
        // 添加到导航栏左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("leftBarButtonItemDidClick"))

        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("rightBarButtonItemDidClick"))
        
        // 添加标题按钮
        navigationItem.titleView = titleButton
        
        // 监听标题按钮发出的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleStateChange"), name: PopoverAnimationDidShow, object: popoverAnimationManager)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleStateChange"), name: PopoverAnimationDidDismiss, object: popoverAnimationManager)
    }
    
    // MARK: - 监听点击事件
    @objc private func titleStateChange() {
        
        // 修改导航条标题按钮箭头方向
        titleButton.selected = !titleButton.selected
    }
    
    @objc private func titleButtonDidClick(titleButton: JWTitleButton) {
    
        // 创建菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        if let menuVC = sb.instantiateInitialViewController() {
            
            // 自定义设置Model出来的VC
            // 设置负责自定义转场的代理
            menuVC.transitioningDelegate = popoverAnimationManager
            // 设置转场样式 不需要系统的
            menuVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            presentViewController(menuVC, animated: true, completion: nil)
        }
    }
    
    @objc private func leftBarButtonItemDidClick() {
        
        NSLog("")
    }
    
    @objc private func rightBarButtonItemDidClick() {
        
        // 创建二维码控制器
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let QRCodeVC = sb.instantiateInitialViewController()!
        
        // 展现二维码控制器
        presentViewController(QRCodeVC, animated: false, completion: nil)
    }
    
    // MARK: - 懒加载
    private lazy var popoverAnimationManager: PopoverAnimationManager = {
        
        let pop = PopoverAnimationManager()
        // 注意height要大于40 否则会有约束冲突
        pop.presentedViewFrame = CGRect(x: 100, y: 56, width: 200, height: 100)
        return pop
    }()
    private lazy var titleButton: JWTitleButton = {
        
        let btn = JWTitleButton()
        btn.setTitle("EvenCoder", forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector("titleButtonDidClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
}


















