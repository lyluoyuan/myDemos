//
//  UserModel.swift
//  ScoreManager
//
//  Created by 邝利军 on 15/7/17.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    
    var id = 0
    var code = ""
    var name = ""
    var avatar = ""
    var phone = ""
    var workHours = 0
    var bank = ""
    var bankNum = ""
    var ptTypeName = ""
    var lock = 0
    var sex = 0
    var bankOwner = ""
    var userIdcard = ""
    var userIdcardImageA = ""
    var userIdcardImageB = ""
    var userRuleStr = ""
    
    init(_ data:JSON) {
        id = data["user_id"].intValue
        code = data["user_code"].stringValue
        name = data["user_name"].stringValue
        avatar = data["user_avatar"].stringValue
        phone = data["user_phone"].stringValue
        workHours = data["user_work_hours"].intValue
        bank = data["user_bank"].stringValue
        bankNum = data["user_bank_num"].stringValue
        ptTypeName = data["pt_type_name"].stringValue
        lock = data["user_lock"].intValue
        sex = data["user_sex"].intValue
        bankOwner = data["user_bank_owner"].stringValue
        userIdcard = data["user_idcard"].stringValue
        userIdcardImageA = data["user_idcard_image_a"].stringValue
        userIdcardImageB = data["user_idcard_image_b"].stringValue
        userRuleStr = data["user_rule_str"].stringValue
    }
    
    func sexText() -> String {
        if sex == 1 {
            return "男"
        } else if sex == 2 {
            return "女"
        }
        return "未知"
    }
   
}
