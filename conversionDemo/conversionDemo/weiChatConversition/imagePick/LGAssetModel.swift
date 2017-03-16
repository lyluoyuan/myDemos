//
//  LGAssetModel.swift
//  LGChatViewController
//
//  Created by jamy on 10/23/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import Foundation
import Photos

class LGAssetModel {
    var select: Bool
    var asset: PHAsset
    
    init(asset: PHAsset, select: Bool) {
        self.asset = asset
        self.select = select
    }
    
    func setSelect(isSelect: Bool) {
        self.select = isSelect
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com