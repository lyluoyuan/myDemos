//
//  MessageModel.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class MessageModel: NSObject {
    var title = "title"
    var content = "contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent"
    var time = "2-18 21:20"
    override init() {
        super.init()
    }
    init(title:String,content:String,time:String) {
        self.title = title
        self.content = content
        self.time = time
    }
}
