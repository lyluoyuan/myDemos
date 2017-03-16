//
//  ZMExUIViewController.swift
//  Innfu
//
//  Created by qingyin02 on 15/4/30.
//  Copyright (c) 2015年 zmaitech. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addBackNavBar(dismiss:Bool = false) {
        let button = UIButton()
        let spacing:CGFloat = 30
        button.frame = CGRectMake(0, 0, 40, 40)
        button.contentMode = UIViewContentMode.Left
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
//        button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
//        button.setTitle("返回", forState: UIControlState.Normal)
        button.setImage(UIImage(named: "icon_back_normal"), forState: UIControlState.Normal)
        button.addTarget(self, action: dismiss ? "backDismissClick:" : "backClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        button.addTarget(self, action: "backDismissClick:", forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
//        let leftButton = VBFPopFlatButton(frame: CGRectMake(0, 0, 30, 30), buttonType: FlatButtonType.buttonBackType, buttonStyle: FlatButtonStyle.buttonPlainStyle, animateToInitialState: false)
//        leftButton.tintColor = textColorYellow
//        leftButton.lineThickness = 2
//        leftButton.addTarget(self, action: dismiss ? "backDismissClick:" : "backClick:", forControlEvents: UIControlEvents.TouchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    
    func backClick(sender:AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func backDismissClick(sender:AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

