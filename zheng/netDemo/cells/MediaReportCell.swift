//
//  MediaReportCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/5.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class MediaReportCell: UITableViewCell {

    @IBOutlet weak var mediaReportImageView: UIImageView!
    @IBOutlet weak var mediaReportTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    var data:MediaReportModel!{
        didSet{
            mediaReportImageView.zm_setImageUrl(data.image)
            mediaReportTitleLabel.text = data.title
            timeLabel.text = data.time
            contentLabel.text = data.content
        }   
    }
}
