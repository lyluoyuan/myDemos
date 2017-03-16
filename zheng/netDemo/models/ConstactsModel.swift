//
//  ConstactsModel.swift
//  ScoreManager
//
//  Created by 邝利军 on 15/7/26.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

class ConstactsModel: NSObject {
   
    var id = 0
    var name = ""
    var avatar = ""
    var content = ""
    var count = 0
    var time = ""
    
    init(_ data:JSON) {
        id = data["chief_id"].intValue
        name = data["user_name"].stringValue
        avatar = data["user_avatar"].stringValue
        content = data["msg_content"].stringValue
        count = data["msg_count"].intValue
        time = data["msg_time_create"].stringValue
    }
    
    override init() {
        
    }
    
}
