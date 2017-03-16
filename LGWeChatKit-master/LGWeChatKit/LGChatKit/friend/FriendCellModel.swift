//
//  FriendCellModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/21/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation


class contactCellModel {
    let name: Observable<String>
    let phone: Observable<String>
    let iconName: Observable<String>
    
    init(_ friend: Friend) {
        name = Observable(friend.name)
        phone = Observable(friend.phone)
        iconName = Observable(friend.iconName)
    }
}

class contactSessionModel {
    let key: Observable<String>
    let friends: Observable<[contactCellModel]>
    
    init() {
        key = Observable("")
        friends = Observable([])
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com