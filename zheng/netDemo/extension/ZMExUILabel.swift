//
//  ZMExUILabel.swift
//  eshangk-ios
//
//  Created by zm002 on 15/3/3.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
    func addLineSpace(lineHeight:CGFloat = 8) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        let attributes = [NSParagraphStyleAttributeName : style]
        self.attributedText = NSAttributedString(string: self.text == nil ? "" : self.text!, attributes:attributes)
    }
    
    func addLineSpaceForAttrubute(attrString:NSMutableAttributedString,_ lineHeight:CGFloat = 8) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
//        let attributes = [NSParagraphStyleAttributeName : style]
        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
    func addIndent(indent:CGFloat = 30) {
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = indent
        let attributes = [NSParagraphStyleAttributeName : style]
        self.attributedText = NSAttributedString(string: self.text == nil ? "" : self.text!, attributes:attributes)
    }
    
    func addSubColor(string:String ,substring:String ,color:UIColor) {
        let myMutableString = NSMutableAttributedString(string: string)
        
        var searchRange = NSMakeRange(0,string.characters.count);
        var foundRange:NSRange!
        while searchRange.location < string.characters.count {
            searchRange.length = string.characters.count-searchRange.location;
            
            foundRange = NSString(string: string).rangeOfString(substring, options: [], range: searchRange)
            if (foundRange.location != NSNotFound) {
                // found an occurrence of the substring! do stuff here
                searchRange.location = foundRange.location+foundRange.length;
                
                myMutableString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(self.font.pointSize),NSForegroundColorAttributeName:color], range: foundRange)
            } else {
                // no more substring to find
                break;
            }
        }
        
        self.attributedText = myMutableString
    }
    func setCustomAttrText(string:String ,substring:String ,color:UIColor?,lineHeight:CGFloat = 8,fontSize:CGFloat?){
        let myMutableString = NSMutableAttributedString(string: string)
        var searchRange = NSMakeRange(0,string.characters.count)
        var foundRange:NSRange!
        let newColor = color == nil ? self.textColor : color
        let newFontSize = fontSize == nil ? self.font.pointSize : fontSize
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        while searchRange.location < string.characters.count {
            searchRange.length = string.characters.count-searchRange.location;
            
            foundRange = NSString(string: string).rangeOfString(substring, options: [], range: searchRange)
            if (foundRange.location != NSNotFound) {
                searchRange.location = foundRange.location+foundRange.length
                myMutableString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(newFontSize!),NSForegroundColorAttributeName:newColor, NSParagraphStyleAttributeName:style], range: foundRange)
            } else {
                break;
            }
        }
        self.attributedText = myMutableString
    }
    func countWith(str : String)->CGFloat{
        self.numberOfLines = 1
        let rect = str.boundingRectWithSize(CGSizeMake(1000, self.frame.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.italicSystemFontOfSize(self.font.pointSize)], context: nil)
        return rect.width
    }

    func setStarText(starText:Int,starSize:CGFloat=10){
        let attrStr = NSMutableAttributedString()
        for _ in 0..<starText {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(named: "icon_goldden_star")
            imageAttachment.bounds = CGRectMake(0, 0, starSize, starSize)
            let attrStrAttachment = NSAttributedString(attachment: imageAttachment)
            attrStr.appendAttributedString(attrStrAttachment)
        }
        self.attributedText = attrStr
    }
    func countRows()->Int{
        var add = 0
        let wholeText = self.text!
        var height : CGFloat = 0
        var rows = 0
        while(true){
            if add > wholeText.characters.count{
                break
            }
            let subString = wholeText.substringToIndex(wholeText.startIndex.advancedBy(add))
            let rect = subString.boundingRectWithSize(CGSizeMake(self.frame.size.width,1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.italicSystemFontOfSize(self.font.pointSize)], context: nil)
            if rect.height > height + 5{
                height = rect.height
                rows++
            }
            add++
        }
        return rows
    }
}