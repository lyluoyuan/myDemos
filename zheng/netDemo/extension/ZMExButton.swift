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
    
    func pinkStyle(sizeStyle:ButtonSizeStyle = .Normal) {
        //        self.setIsAwesome(true);
        //        self.setButtonText(self.titleForState(UIControlState.Normal))
        self.backgroundColor = UIColor(red: 252/255.0, green:110/255.0, blue:81/255.0, alpha:1)
        self.setBackgroundImage(buttonImageFromColor(self.backgroundColor!), forState: UIControlState.Normal)
        let color = UIColor(red: 219/255.0, green:51/255.0, blue:17/255.0, alpha:1)
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Highlighted)
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Selected)
        
        //        self.setTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forUIControlState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setRadius(5.0)
        
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func yellowStyle(sizeStyle:ButtonSizeStyle = .Normal) {
        //        self.setIsAwesome(true);
        //        self.setButtonText(self.titleForState(UIControlState.Normal))
        self.backgroundColor = UIColor.hex( "#ff9933")
        self.setBackgroundImage(buttonImageFromColor(self.backgroundColor!), forState: UIControlState.Normal)
        let color = UIColor.hex( "#996633")
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Highlighted)
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Selected)
        
        //        self.setTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forUIControlState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setRadius(5.0)
    }
    
    func greenStyle(sizeStyle:ButtonSizeStyle = .Normal) {
        self.backgroundColor = headerBgColor
        self.setBackgroundImage(buttonImageFromColor(self.backgroundColor!), forState: UIControlState.Normal)
        let color = UIColor.hex( "#339933")
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Highlighted)
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Selected)
        self.setBackgroundImage(buttonImageFromColor(UIColor.hex( "#BDBDBD")), forState: UIControlState.Disabled)
        
        //        self.setTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forUIControlState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setRadius(3.0)
    }
    
    func blueStyle(sizeStyle:ButtonSizeStyle = .Normal) {
        self.backgroundColor = UIColor.hex( "#4fc1e9")
        self.setBackgroundImage(buttonImageFromColor(self.backgroundColor!), forState: UIControlState.Normal)
        let color = UIColor.hex( "#28a3ce")
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Highlighted)
        self.setBackgroundImage(buttonImageFromColor(color), forState: UIControlState.Selected)
        
        //        self.setTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor()], forUIControlState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setRadius(5.0)
    }
    
    func addGreenBorderStyle(sizeStyle:ButtonSizeStyle = .Normal) {
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = greenColor.CGColor;
        self.layer.borderWidth = 1.0;
        self.addTarget(self, action: "highlightGreenBorder", forControlEvents: UIControlEvents.TouchDown)
        self.addTarget(self, action: "unhighlightGreenBorder", forControlEvents: UIControlEvents.TouchUpInside)
        self.setTitleColor(greenColor)
    }
    
    func highlightGreenBorder() {
        self.layer.borderColor = UIColor.hex( "#17d57e").CGColor;
    }
    
    func unhighlightGreenBorder() {
        self.layer.borderColor = greenColor.CGColor;
    }
    
    
    
    func setTextSize() {
    
    }
    
    func setRightImage() {
        var title = self.titleForState(UIControlState.Normal)
        if title == nil {
            title = ""
        } else {
            title = NSRegularExpression(pattern: "\\n").replace(title, with: "")
        }
        self.titleLabel!.hidden = false
        self.sizeToFit()
        let padding:CGFloat = 4
        let titleWidth = (self.frame.size.width - self.imageView!.frame.size.width)/(title!.isEmpty ? 2 : 1) - padding
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView!.frame.size.width, 0, self.imageView!.frame.size.width);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth+padding,0 , -titleWidth-padding);
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
        let titleSize = NSString(string:self.titleLabel!.text!).sizeWithAttributes(attributes)
        self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0, 0, -titleSize.width)
    }
    
    func addHightLightBackgroundColor() {
        self.setBackgroundImage(buttonImageFromColor(UIColor.hex( "#efefef")), forState: UIControlState.Highlighted)
        self.setBackgroundImage(buttonImageFromColor(UIColor.hex( "#efefef")), forState: UIControlState.Selected)
    }

}