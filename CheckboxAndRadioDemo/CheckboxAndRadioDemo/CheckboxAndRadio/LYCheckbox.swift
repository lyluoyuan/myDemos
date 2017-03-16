//
//  LYCheckbox.swift
//  checkBoxAndRadioDemo
//
//  Created by zm004 on 16/2/4.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LYCheckbox: NSObject {
    var checkButtons = [LYCheckButton]()
    func checkbox(checkButtons: [LYCheckButton],titles: [String], checked: [Int] = []){
        for (index, value) in checkButtons.enumerate(){
            value.contentHorizontalAlignment = .Left
            value.selectStatus = checked.contains(index) ? true : false
            value.setTitle(titles[index], forState: UIControlState.Normal)
            value.addTarget(value, action: "clicked:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        self.checkButtons = checkButtons
    }
    
    func getCheckStatus()->[Int]{
        var checkStatuses = [Int]()
        for (index, value) in checkButtons.enumerate(){
            if value.selectStatus == true{
                checkStatuses.append(index)
            }
        }
        return checkStatuses
    }
}
class LYCheckButton: UIButton {
    var selectStatus : Bool!{
        didSet{
            if selectStatus == false{
                self.setImage(UIImage(named: "field_checkbox_uncheck"), forState: UIControlState.Normal)
            }else{
                self.setImage(UIImage(named: "field_checkbox_check"), forState: UIControlState.Normal)
            }
        }
    }
    func clicked(sender: LYCheckButton){
        sender.selectStatus = !sender.selectStatus
    }
}