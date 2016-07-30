//
//  QRCodeViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/7/30.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    @IBOutlet weak var customTabbar: UITabBar!
    // 冲击波约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    // 容器高度
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    // 冲击波View
    @IBOutlet weak var scanLineView: UIImageView!
    // 容器视图
    @IBOutlet weak var containerView: UIView!
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // 默认选中第一个Tabbar
        customTabbar.selectedItem = customTabbar.items![0]
        // 设置代理
        customTabbar.delegate = self
        // 开始扫面
        startScan()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // 执行动画
        startAnimation()
    }
    
    // MARK: - 内部控制方法

    @IBAction func closeQRCoderVCDidClick(sender: AnyObject) {
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    // 打开相册扫面二维码
    @IBAction func openPhotoAlbumDidClick(sender: AnyObject) {
        NSLog("")
    }
    
    private func startScan() {
        
        // 判断输入是否可以添加到会话中
        if !session.canAddInput(deviceInput) {
            
            return
        }
        // 判断输出是否可以添加到会话中
        if !session.canAddOutput(output) {
            
            return
        }
        // 添加输入和输出
        session.addInput(deviceInput)
        session.addOutput(output)
        // 设置输出可以解析的数据类型
        // 注意: 设置输出对象能够解析的数据类型，必须在输出对象添加到会话之后设置
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        // 添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        // 添加描边图层
        previewLayer.addSublayer(drawLayer)
        // 开始扫描
        session.startRunning()
    }
    
    /**
     冲击波动画
     */
    private func startAnimation() {
        
        // 初始化冲击波的位置
        scanLineCons.constant = -containerHeightCons.constant
        // 更新约束
        view.layoutIfNeeded()
        // 执行动画
        UIView.animateWithDuration(2.0) { () -> Void in
            
            // 重复执行动画
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineCons.constant = self.containerHeightCons.constant
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - 懒加载
    // 创建输入
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        
       let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch{
            
            return nil
        }
    }()
    // 创建输出
    private lazy var output: AVCaptureMetadataOutput = {
        
        let output = AVCaptureMetadataOutput()
        let containerFrame = self.containerView.frame
        let size = UIScreen.mainScreen().bounds.size
        /**
        注意: rectOfInterest接收的都是比例
             rectOfInterest是按照横屏的做上下为原点
        */
        output.rectOfInterest = CGRect(x: containerFrame.origin.y / size.height, y: containerFrame.origin.x / size.width, width: containerFrame.size.height / size.height, height: containerFrame.size.width / size.width)
        return output
    }()
    // 创建会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    // 创建预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        // 设置layer的frame
        layer.frame = self.view.bounds
        return layer
    }()
    // 秒表图层
    private lazy var drawLayer: CALayer = {
       
        let layer = CALayer()
        layer.frame = self.view.bounds
        return layer
    }()
}

extension QRCodeViewController: UITabBarDelegate {
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        containerHeightCons.constant = (item.tag == 0) ? 300 : 100
        // 移除图层上所有动画
        scanLineView.layer.removeAllAnimations()
        // 开始动画
        startAnimation()
    }
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // 获取二维码的位置大小
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // 清空描边
        clearCorners()
        if metadataObjects.count > 0 {
            
            let objc = metadataObjects.last!
            // 将AVCaptureMetadataOutputObject对象中的corners转换为我们能够识别的坐标
            let res = previewLayer.transformedMetadataObjectForMetadataObject(objc as! AVMetadataObject)
            drawCorners(res as! AVMetadataMachineReadableCodeObject)
        }
    }
    
    // MARK: - 描二维码边
    private func drawCorners(dataObject: AVMetadataMachineReadableCodeObject) {
        
        // 创建一个图层专门用于绘制二维码描边
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.orangeColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 2
        // 创建一个路径
        let path = UIBezierPath()
        var potion: CGPoint = CGPointZero
        var index = 0
        // 移动到起点
        CGPointMakeWithDictionaryRepresentation(dataObject.corners[index++] as! CFDictionaryRef, &potion)
        path.moveToPoint(potion)
        // 连接到其它的点
        while index < dataObject.corners.count {
            
            CGPointMakeWithDictionaryRepresentation(dataObject.corners[index++] as! CFDictionaryRef, &potion)
            path.addLineToPoint(potion)
        }
        // 关闭路劲
        path.closePath()
        // 设置路径
        shapeLayer.path = path.CGPath
        // 绘制路径
        path.stroke()
        // 添加图层
        drawLayer.addSublayer(shapeLayer)
    }
    
    // 清空描边
    private func clearCorners() {
        
        if let subLayer = drawLayer.sublayers {
            
            for layer in subLayer {
                
                layer.removeFromSuperlayer()
            }
        }
    }
}













