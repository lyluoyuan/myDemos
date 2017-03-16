//
//  LGEmotionManager.swift
//  LGChatViewController
//
//  Created by jamy on 10/16/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit

class LGEmotionManager: NSObject {
    
    var emotionArray: NSArray!
    
    var emotionDict: [String: NSArray]!
    
    /// dispatch_once
    static let shareInstance: LGEmotionManager = {
        return LGEmotionManager()
    }()
    
    
    override init() {
        super.init()
        if let fileName = NSBundle.mainBundle().pathForResource("emoji_config", ofType: "json") {
            emotionArray = try! NSJSONSerialization.JSONObjectWithData(NSData(contentsOfFile: fileName)!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            
            if emotionArray.count > 0 {
                emotionArray.enumerateObjectsUsingBlock({ (objc: AnyObject, index: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                    let emotionData = objc as! NSArray
                    self.emotionDict = [(emotionData[1] as! String): [emotionData[0], emotionData[2]]]
                })
            }
        }
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com