//
//  RegionCollectionCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class RegionCollectionCell: UICollectionViewCell {
    @IBOutlet weak var regionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        regionButton.layer.borderColor = headerBgColor.CGColor
        regionButton.layer.borderWidth = 1
        regionButton.layer.cornerRadius = 5
    }
    var data:String!{
        didSet{
            regionButton.setTitle(data, forState: UIControlState.Normal)
        }
    }
}
