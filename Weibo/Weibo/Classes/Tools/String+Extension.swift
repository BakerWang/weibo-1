//
//  String+Extension.swift
//  Weibo
//
//  Created by 黄进文 on 16/8/3.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

extension String {
    
    
    func cache() -> String {
        
        let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        return (cachePath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    func doc() -> String {
        
        let docPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        return (docPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
    }
    
    func tmp() -> String {
        
        let tmpPath = NSTemporaryDirectory()
        return (tmpPath as NSString).stringByAppendingPathComponent((self as NSString).pathComponents.last!)
    }
}