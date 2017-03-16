//
//  FriendModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/20/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation


struct Friend {
    let name: String
    let phone: String
    let iconName: String
}


struct FriendSession {
    let key: String
    let friends: [Friend]
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com