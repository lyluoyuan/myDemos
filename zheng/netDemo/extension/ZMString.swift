//
//  ZMString.swift
//  ScoreManager
//
//  Created by 邝利军 on 15/5/15.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

extension String {
    func valdateForRegex(regexpPattern:String) -> Bool {
        return NSRegularExpression(pattern: regexpPattern).isMatch(self)
    }
}
