//
//  EXSmartLabel.swift
//  SmartLabel
//
//  Created by zm004 on 16/7/1.
//  Copyright © 2016年 zm004. All rights reserved.
//  NSLinkAttributeName:NSURL(string:"www.baidu.com")!

import UIKit

extension YYTextView{
    func setSmartContent(pattern:String){
        self.editable = false
        self.userInteractionEnabled = true
        let wholeText = self.text!
        self.font = UIFont.systemFontOfSize(15)
        let resultAttrStr = NSMutableAttributedString(string: wholeText)
        resultAttrStr.addAttributes([NSFontAttributeName:self.font!], range: NSMakeRange(0, wholeText.characters.count))
//        let matchArr = NSRegularExpression(pattern: pattern).matches(wholeText) as! [String]
        let detailMatchArr = NSRegularExpression(pattern: pattern).matchesWithDetails(wholeText) as! [RxMatch]
        for d in detailMatchArr{
            let matchRange = d.range
            let btn = NSMutableAttributedString(string: d.value)
            btn.yy_font = self.font!
            btn.yy_color = UIColor.greenColor()
            let heighLight = YYTextHighlight()
            heighLight.setColor(UIColor.lightGrayColor())
            heighLight.tapAction = { view, text, range ,rect in
                print("range: \(range)")
                print("rect: \(rect)")
            }
            
            btn.yy_setTextHighlight(heighLight, range: NSMakeRange(0, btn.length))
            resultAttrStr.replaceCharactersInRange(matchRange, withAttributedString: btn)
        }
        self.attributedText = resultAttrStr
        self.editable = false
//        self.scrollEnabled = false
        self.textContainerInset = UIEdgeInsetsZero
        self.frame.size.height = self.contentSize.height
        
        self.sizeToFit()
    }
}
