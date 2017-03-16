//
//  LGConversionListCellModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/20/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation


class LGConversionListCellModel {
    let iconName: Observable<String>
    let userName: Observable<String>
    let lastMessage: Observable<String>
    let timer: Observable<String>
    
    private let emptyString = ""
    
    init() {
        iconName = Observable(emptyString)
        userName = Observable(emptyString)
        lastMessage = Observable(emptyString)
        timer = Observable(emptyString)
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com