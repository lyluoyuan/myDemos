//
//  MessageCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wholeArticleButton: UIButton!
    @IBOutlet weak var wholeArticleButtomConstraint: NSLayoutConstraint!
    @IBOutlet weak var wholeArticleButtonHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        wholeArticleButton.setTitleColor(headerBgColor, forState: UIControlState.Normal)
        self.backgroundColor = mainBgColor
    }
    var data:MessageModel!{
        didSet{
            messageTitleLabel.text = data.title
            contentLabel.text = data.content
            if contentLabel.countRows() > 3{
                wholeArticleButton.hidden = false
                wholeArticleButtomConstraint.constant = 5
                wholeArticleButtonHeightConstraint.constant = 20
            }else{
                wholeArticleButton.hidden = true
                wholeArticleButtomConstraint.constant = 0
                wholeArticleButtonHeightConstraint.constant = 0
            }
            timeLabel.text = data.time
        }        
    }
    @IBAction func showWholeArticleAction(sender: UIButton) {
        SweetAlert(false).buildAlert(data.title, subTitle: data.content, style: .None, otherButtonTitle: "删除") { (isOtherButton, alert) -> Void in
            alert.hide()
            if isOtherButton{
                
            }
        }.show()
    }
}
