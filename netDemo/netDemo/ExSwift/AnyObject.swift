//
//  AnyObject.swift
//  ScoreManager
//
//  Created by zm004 on 16/1/13.
//  Copyright © 2016年 zm002. All rights reserved.
//

import UIKit

func anyToString(anyObject : AnyObject)->String{
    if let str = anyObject as? String{
        return str
    }
    return ""
}

func anyToNSNumber(anyObject : AnyObject)->NSNumber{
    if let str = anyObject as? NSString{
        return NSNumber(double: str.doubleValue)
    }
    return 0
}