//
//  CityCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        cityButton.layer.borderColor = headerBgColor.CGColor
        cityButton.layer.borderWidth = 1
        cityButton.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
