//
//  RegionStreetCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/4.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class RegionStreetCell: UITableViewCell {

    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var downArrowImageView: UIImageView!

    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var labelView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        labelView.layer.cornerRadius = 3
        labelView.clipsToBounds = true
        downView.layer.cornerRadius = 3
        downView.clipsToBounds = true
    }
    var data:String!{
        didSet{
            streetLabel.text = data
        }
    }
    
}
