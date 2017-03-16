//
//  RegionHeaderCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/4.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class RegionHeaderCell: UITableViewCell {

    @IBOutlet weak var regionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data:String!{
        didSet{
            regionLabel.text = data
        }
    }

}
