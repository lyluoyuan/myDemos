//
//  ZMExImageView.swift
//  eshangk-ios
//
//  Created by zm002 on 15/1/23.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func zm_setImageUrl(url:String,var defaultImage:String! = nil) {
        if defaultImage == nil {
            defaultImage = "defaultImage-lsdq"
        }
        if !url.isEmpty {
            self.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: defaultImage))
        }
        
    }
    
}