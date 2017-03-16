//
//  ZMExTextField.swift
//  eshangk-ios
//
//  Created by 邝利军 on 15/1/7.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit


extension UITextField {
    
    func valdateForRegex(regexpPattern:String) -> Bool {
        return NSRegularExpression(pattern: regexpPattern).isMatch(self.text)
    }
    
    func validateForPhone() -> Bool {
        let regexpPattern = "^[1][0-9]{10}$"

        return valdateForRegex(regexpPattern);
    }
    
    func validateForNotEmpty() -> Bool {
        let regexpPattern = "^.+$"
        return valdateForRegex(regexpPattern);
    }
    
    func validateForEmail() -> Bool {
        let regexpPattern = "^[a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6}$"
        return valdateForRegex(regexpPattern);
    }

    func validateForInteger() -> Bool  {
        let regexpPattern = "^[0-9]+$"
        return valdateForRegex(regexpPattern);
    }
    
    func addLabel(name:String,color:UIColor = UIColor.hex( "#999999")) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: self.frame.size.height))
        label.text = name
        label.textColor = color
        self.leftView = label
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    func addBottomLine(color:UIColor = UIColor.hex( "#EEEEEE")) {
        self.borderStyle = UITextBorderStyle.None
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
        bottomBorder.backgroundColor = color.CGColor
        self.layer.addSublayer(bottomBorder)
        self.layer.setValue(bottomBorder, forKey: "bottomborder")
    }
    
    func setBottomLineColor(color:UIColor) {
        if let bottomBorder = self.layer.valueForKey("bottomborder") as? CALayer {
            bottomBorder.backgroundColor = color.CGColor
        }
    }
    
    func setPadding(padding:CGFloat = 5) {
        leftViewMode = UITextFieldViewMode.Always
        leftView = UIView(frame: CGRectMake(0, 0, padding, frame.height))
        leftView?.backgroundColor = UIColor.clearColor()
    }
    
    public func setStyle() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.hex( "#dddddd").CGColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.borderStyle = UITextBorderStyle.None
        self.setPadding()
    }
    
//    public func fixAppStyle() {
//        self.font =  UIFont(name: appFontFamily, size: self.font.pointSize)
//    }
    
    public func fixSecurityFontSize() {
//        self.font =  UIFont(name: appFontFamily, size: 10)
    }
    func configLeftView(left:String){
        let leftButton = ViewButton(type: .Custom)
        if left != ""{
            leftButton.setImage(UIImage(named: left), forState: UIControlState.Normal)
        }
        leftButton.frame = CGRectMake(0, 0, 20, 20)
        self.leftView = leftButton
        self.leftViewMode = .Always
    }
}
class ViewButton : UIButton{
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0, 0, 15, 20)
    }
}
