//
//  TestView.swift
//  checkBoxAndRadioDemo
//
//  Created by zm004 on 16/3/22.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class TestView: UIView {
    override func layoutSubviews() {
        let imageView : UIImageView? = UIImageView()
        imageView?.backgroundColor = UIColor.greenColor()
        self.addSubview(imageView!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        let imageLeft = NSLayoutConstraint(item: imageView!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 4)
        let imageCenterY = NSLayoutConstraint(item: imageView!, attribute: NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        let imageHeight = NSLayoutConstraint(item: imageView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 20)
        let imageWidth = NSLayoutConstraint(item: imageView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 20)
        self.addConstraints([imageLeft, imageCenterY, imageHeight, imageWidth])
    }
}
