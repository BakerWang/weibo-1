//
//  HTTPNetworkTools.swift
//  Weibo
//
//  Created by 黄进文 on 16/8/1.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit
import AFNetworking

class HTTPNetworkTools: AFHTTPSessionManager {

    // 单例
    static let shareInstance: HTTPNetworkTools = {
        
        let url = NSURL(string: "https://api.weibo.com/")
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let instance = HTTPNetworkTools(baseURL: url, sessionConfiguration: configuration)
        instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as Set<NSObject>
        return instance
    }()
}
