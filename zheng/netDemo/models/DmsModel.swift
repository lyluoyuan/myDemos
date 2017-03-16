//
//  DmsModel.swift
//  ScoreManager
//
//  Created by 邝利军 on 15/7/27.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

class DmsModel: NSObject {
    
    var dmsContentId = 0
    
    var dmsId = 0
    var userId = 0
    var dmsContent = ""
    var dmsContentStatus = 0
    var dmsContentTimeCreate = ""
    var flgMe = 0
    var userAvatar = ""
    var userName = ""
    
    init(_ data:JSON) {
        dmsContentId = data["dms_content_id"].intValue
        dmsId = data["dms_id"].intValue
        userId = data["userId"].intValue
        dmsContent = data["dms_content"].stringValue
        dmsContentStatus = data["dms_content_status"].intValue
        dmsContentTimeCreate = data["dms_content_time_create"].stringValue
        flgMe = data["flg_me"].intValue
        userAvatar = data["user_avatar"].stringValue
        userName = data["user_name"].stringValue
    }
}
