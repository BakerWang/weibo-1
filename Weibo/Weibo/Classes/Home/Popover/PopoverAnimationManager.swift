//
//  PopoverAnimationManager.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/30.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

let PopoverAnimationDidShow = "PopoverAnimationDidShow"
let PopoverAnimationDidDismiss = "PopoverAnimationDidDismiss"

class PopoverAnimationManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    // 标记视图是否展现
    private var isPresented: Bool = true
    // 动态修改展示视图的frame
    var presentedViewFrame: CGRect = CGRectZero
    
    // MARK: - UIViewControllerTransitioningDelegate
    // 该方法用于返回负责转场的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let presentedVC = JWPresentationController(presentedViewController: presented, presentingViewController: presenting)
        presentedVC.presentedViewFrame = presentedViewFrame
        return presentedVC
    }
    
    // 告诉系统谁来负责转场如何出现
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true // 展示
        // 通知改变标题箭头方向 self 发通知
        NSNotificationCenter.defaultCenter().postNotificationName(PopoverAnimationDidShow, object: self)
        return self
    }
    
    // 告诉系统谁来负责转场如何消失
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false // 消失
        // self 发通知
        NSNotificationCenter.defaultCenter().postNotificationName(PopoverAnimationDidDismiss, object: self)
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    // 告诉系统转场动画出现消失需要多少时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.25
    }
    
    // 无论转场动画出现还是消失都会调用这个方法 我们需要在这个方法中自定义转场动画的样式
    // 改变转场方式
    // transitionContext: 上下文, 该上下文中就包含了我们需要的所有数据
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(transitionContext)
        if isPresented {
            
            // 拿到被展现的视图
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            // 注意: 一旦自定义转场 这时系统就不会帮我们做任何操作 包括将需要展示的view添加到containerView上
            transitionContext.containerView()?.addSubview(toView)
            
            // 设置盲点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
            // 控制器被展现的视图如何显示和消失
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                toView.transform = CGAffineTransformIdentity // 还原属性
                }) { (_) -> Void in
                    
                    // 注意: 如果是自定义转场 一定要在动画执行完毕之后告诉系统动画已经执行完毕 否则有可能引发一些未知的错误
                    transitionContext.completeTransition(true)
            }
        }
        else {
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                // 注意: 消失的动画一下子就不见得原因是因为CGFloat是不准确的
                // 想解决这个问题 只需要将y值改为一个非常小的即可
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.0001)
                }, completion: { (_) -> Void in
                    
                    transitionContext.completeTransition(true)
            })
            
        }
    }
}
