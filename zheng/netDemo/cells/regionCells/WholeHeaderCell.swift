//
//  WholeHeaderCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class WholeHeaderCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var data:String!{
        didSet{
            headerLabel.text = data
        }        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
