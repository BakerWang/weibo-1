//
//  UserAccountModel.swift
//  Weibo
//
//  Created by 黄进文 on 16/8/1.
//  Copyright © 2016年 黄进文. All rights reserved.
//

import UIKit

class UserAccountModel: NSObject, NSCoding {

    var access_token: String?
    var expires_in: NSNumber?
    var uid: String?
    
    // MARK: - 生命周期方法
    init(dict: [String: AnyObject]) {
        
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        

    }
    
    override var description: String {
    
        let property = ["access_token", "expires_in", "uid"]
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }
    
    // MARK: - 外部控制方法
    // 保存信息
    func saveUserAccount() -> Bool {
        
        // 获取Document路径
        let docPath = "useraccount.plist".doc()
        
        NSLog("filePath = \(docPath)")
        return NSKeyedArchiver.archiveRootObject(self, toFile: docPath)
    }
    
    // MARK: - NSCoding归档
    // 将对象写入到文件中
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    // 从文件中读取对象
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
    }
}
