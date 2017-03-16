//
//  LYRadio.swift
//  checkBoxAndRadioDemo
//
//  Created by zm004 on 16/2/4.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LYRadio: NSObject {
    var radioButtons = [LYRadioButton]()
    var selected = 0
    func radio(radioButtons: [LYRadioButton], titles: [String], selected: Int = 0){
        for (index, value) in radioButtons.enumerate(){
            value.lyRadio = self
            value.lyTag = index
            value.selectStatus = selected == index ? true : false
            value.setTitle(titles[index], forState: UIControlState.Normal)
            value.addTarget(value, action: "clicked:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        self.radioButtons = radioButtons
    }
}

class LYRadioButton: UIButton {
    var lyRadio = LYRadio()
    var lyTag = 0
    var imageRatio = CGRectMake(0.03, 0, 0.1, 0)//y、高无效
    var titleRatio = CGRectMake(0.14, 0, 0.82, 0.95)//y无效
    var lyFont : CGFloat = 17
    var selectStatus : Bool!{
        didSet{
            self.contentHorizontalAlignment = .Left
            if selectStatus == false{
                self.setImage(UIImage(named: "field_radio_uncheck"), forState: UIControlState.Normal)
            }else{
                self.setImage(UIImage(named: "field_radio_check"), forState: UIControlState.Normal)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.numberOfLines = 0
    }
    func clicked(sender: LYRadioButton){
        for r in lyRadio.radioButtons{
            if r.lyTag != sender.lyTag{
                r.selectStatus = false
            }else{
                sender.selectStatus = true
                lyRadio.selected = sender.lyTag
            }
        }
    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageWidth = imageRatio.width*frame.width
        let imageHeight = imageWidth
        let imageRect = CGRectMake(imageRatio.origin.x*frame.width, (frame.height - imageHeight)/2, imageWidth, imageHeight)
        return imageRect
    }
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleWidth = titleRatio.width*frame.width
        let titleHeight = self.currentTitle!.boundingRectWithSize(CGSizeMake(titleWidth, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.italicSystemFontOfSize(lyFont)], context: nil).height
        let titleRect = CGRectMake(titleRatio.origin.x*frame.width, (frame.height-titleHeight)/2, titleWidth, titleHeight)
        if titleHeight > self.frame.height*titleRatio.height{
            self.frame.size.height = titleHeight/titleRatio.height
        }
        return titleRect
    }
}