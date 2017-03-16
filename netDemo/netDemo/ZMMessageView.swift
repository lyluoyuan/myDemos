//
//  ZMMessageView.swift
//  Innfu
//
//  Created by qingyin02 on 15/5/17.
//  Copyright (c) 2015年 zmaitech. All rights reserved.
//

import UIKit

class ZMMessageView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var applicationKeyWindow:UIWindow!
    var heartbeatImageView:UIImageView!
    var msgLabel:UILabel!
    
    init() {
        super.init(frame: CGRectMake(0, 64, screenWidth, 30))
        
        msgLabel = UILabel(frame: CGRectMake(0, 0, screenWidth, 30))
        msgLabel.font = msgLabel.font.fontWithSize(14)
        msgLabel.textColor = UIColor.hex( "#666666")
        msgLabel.textAlignment = NSTextAlignment.Center
        
        self.addSubview(msgLabel)
        
        self.backgroundColor = UIColor(color: UIColor.hex( "#ffeea8"), alpha: 0.9)
        
        self.addGestureTapAction("dismissSelf", target: self)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class var sharedInstance: ZMMessageView {
        struct Static {
            static var instance: ZMMessageView?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ZMMessageView()
        }
        
        return Static.instance!
    }
    
    class func show(msg:String = "",top:CGFloat = 64) {
        // get window
        var applicationKeyWindow:UIWindow! = nil
        let frontToBackWindows = Array(UIApplication.sharedApplication().windows.reverse()) 
        for window in frontToBackWindows {
            if window.windowLevel == UIWindowLevelNormal {
                applicationKeyWindow = window;
                break
            }
        }
        if applicationKeyWindow == nil {
            return
        }
        applicationKeyWindow.addSubview(ZMMessageView.sharedInstance)
        
        ZMMessageView.sharedInstance.msgLabel.text = msg
        if ZMMessageView.sharedInstance.alpha != 1 {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                ZMMessageView.sharedInstance.alpha = 1
                }) { (finished) -> Void in
                    delay(2) {
                        ZMMessageView.dismiss()
                    }
            }
        }
    }
    
    class func dismiss() {
        if ZMMessageView.sharedInstance.alpha != 0 {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                ZMMessageView.sharedInstance.alpha = 0
                }) { (finished) -> Void in
                    
            }
        }
    }
    
    func dismissSelf() {
        ZMMessageView.dismiss()
    }
}
