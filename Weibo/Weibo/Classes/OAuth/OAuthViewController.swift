//
//  OAuthViewController.swift
//  Weibo
//
//  Created by 黄进文 on 16/8/1.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    let WB_App_Key = "242752364"
    let WB_App_Secret = "ba31ba5ae8c8dcbc4ecbb0e936397903"
    let WB_Redirect_URI = "http://www.loveq.cn"
    
    override func loadView() {
        
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "登录"
        view.backgroundColor = UIColor.whiteColor()
        
        // 添加导航条
        setupNav()
        
        // 获取未授权的RequestToken(登录界面)
        loadOauthLogin()
    }
    
    // MARK: - 内部控制方法
    /**
    授权登录
    */
    private func loadOauthLogin() {
    
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_Key)&redirect_uri=\(WB_Redirect_URI)"
        guard let url = NSURL(string: urlStr) else {
        
            NSLog("创建URL失败")
            return
        }
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    /**
    初始化导航条
    */
    private func setupNav() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("closeDidClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("rightDidClick"))
    }
    
    @objc private func closeDidClick() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func rightDidClick() {
        
        NSLog("")
    }
    
    // MARK: - 懒加载
    private lazy var webView: UIWebView = {
       
        let web = UIWebView()
        web.delegate = self
        return web
    }()
}

extension OAuthViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        SVProgressHUD.showInfoWithStatus("正在加载中", maskType: SVProgressHUDMaskType.Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        SVProgressHUD.dismiss()
        let js = "document.getElementById('userId').value='jinhuangwen@sina.cn';"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
//    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
//        
//        SVProgressHUD.showErrorWithStatus("加载失败", maskType: SVProgressHUDMaskType.Black)
//    }
    
    // 代理方法用于控制是否允许发起请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        /**
        得到的urlStr是可选的。如果是nil那么就直接进入,reture true
        如果不是nil，那么判断是不是http://www.loveq.cn，如果不是那么就进入return true
        */
        guard let urlStr = request.URL?.absoluteString where urlStr.hasPrefix("http://www.loveq.cn") else {
            
            return true
        }
        
        // 判断是否授权成功
        guard !urlStr.containsString("?error_uri=") else {
            
            SVProgressHUD.showErrorWithStatus("授权失败", maskType: SVProgressHUDMaskType.Black)
            return false
        }
        
        // 授权成功，截取code后面的内容
        if let str = request.URL?.query {
            
            // 截取code后面字符串
            let code = str.substringFromIndex("code=".endIndex)
            loadingAccessToken(code)
        }
        
        return false
    }
    
    /**
     根据code获取AccessToken
     
     - parameter code: 已经授权的RequestToken
     */
    private func loadingAccessToken(code: String) {
        
        let path = "oauth2/access_token"
        let parameters = ["client_id": WB_App_Key, "client_secret": WB_App_Secret, "grant_type": "authorization_code", "code": code, "redirect_uri": WB_Redirect_URI]
        HTTPNetworkTools.shareInstance.POST(path, parameters: parameters, success: { (_, JSON) -> Void in
            
            /**
            let data = try! NSJSONSerialization.dataWithJSONObject(JSON, options: NSJSONWritingOptions.PrettyPrinted)
            let json = NSString(data: data, encoding: NSUTF8StringEncoding)
            NSLog(json)
            */
            guard let dict = JSON as? [String: AnyObject] else {

                return
            }
            let userAccout = UserAccountModel(dict: dict) // 字典转模型
            userAccout.saveUserAccount()
            
            }) { (_, error) -> Void in
                
                NSLog(error)
        }
    }
}

















