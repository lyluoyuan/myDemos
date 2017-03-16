//
//  ZMExButton.swift
//  eshangk-ios
//
//  Created by zm002 on 15/1/5.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

enum ButtonSizeStyle {
    case Big
    case Normal
    case Small
}

extension UIButton {
    
    func buttonImageFromColor(color:UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    var aaa:Int!{
        return 1
    }
    
    func setTopImage(image:String,highlightImage:String! = nil) {
        
        self.setImage(UIImage(named: image), forState: UIControlState.Normal)
        if highlightImage != nil {
            self.setImage(UIImage(named: highlightImage), forState: UIControlState.Highlighted)
        }
//        self.backgroundColor = UIColor.clearColor()
//        self.sizeToFit()
        let spacing:CGFloat = 6
        let imageSize = self.imageView!.image!.size
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(imageSize.height + spacing),0)
        let attributes = [NSFontAttributeName:self.titleLabel!.font]
        self.titleLabel?.numberOfLines = 0
        let titleSize = NSString(string:self.titleLabel!.text!).sizeWithAttributes(attributes)
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width)
    }
    
    
}