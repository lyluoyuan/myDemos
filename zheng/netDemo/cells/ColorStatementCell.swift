//
//  ColorStatementCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ColorStatementCell: UITableViewCell {

    @IBOutlet weak var statementLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = colorView.frame.width/2
        colorView.clipsToBounds = true
    }
    var data : PieItem!{
        didSet{
            statementLabel.text = data.itemDescription
            colorView.backgroundColor = data.color
        }
    }
}
