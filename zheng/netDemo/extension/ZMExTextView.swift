//
//  ZMExTextView.swift
//  eshangk-ios
//
//  Created by zm002 on 15/3/3.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

extension UITextView {

    func setLineSpace(lineHeight:CGFloat = 50) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        let attributes = [NSParagraphStyleAttributeName : style]
        self.attributedText = NSAttributedString(string: self.text, attributes:attributes)
    }
    
    public func setStyle() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.hex( "#dddddd").CGColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true    }
}