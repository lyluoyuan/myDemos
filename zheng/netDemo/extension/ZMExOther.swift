//
//  ZMExOther.swift
//  Innfu
//
//  Created by qingyin02 on 15/5/18.
//  Copyright (c) 2015年 zmaitech. All rights reserved.
//

import UIKit

extension UIBezierPath {
    
    convenience init(rect: CGSize) {
        self.init()
        moveToPoint(CGPoint(x:rect.width/2, y:0))
        addLineToPoint(CGPoint(x:0, y:rect.height))
        addLineToPoint(CGPoint(x:rect.width, y:rect.height))
        closePath()
    }
    
}
