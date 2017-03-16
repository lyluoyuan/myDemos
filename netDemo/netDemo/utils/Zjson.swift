//
//  Zjson.swift
//  eshangk-ios
//
//  Created by zm002 on 14/12/30.
//  Copyright (c) 2014年 zm002. All rights reserved.
//

import UIKit

class Zjson {
   
    var items = [JSON]()
    var success = false
    var addon = JSON("{}")
    var detail = ""
    var code = 200
    var totalCount = 0
    
    var json:JSON

    init(json:JSON) {
        self.json = json
        items = json["items"].arrayValue
        success = json["success"].boolValue
        addon = json["addon"]
        detail = json["detail"].stringValue
        code = json["code"].intValue
        totalCount = json["totalCount"].intValue
    }
}
