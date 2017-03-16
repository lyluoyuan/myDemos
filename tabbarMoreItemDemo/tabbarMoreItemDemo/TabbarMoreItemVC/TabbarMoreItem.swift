//
//  TabbarMoreItem.swift
//  tabbarMoreItemDemo
//
//  Created by zm004 on 16/5/11.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class TabbarMoreItem: UIView {
    var itemImageView = UIImageView()
    var itemTitleLabel = UILabel()
    var belongedVC : TabbarMoreItemViewController!
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemImageView.frame = CGRectMake(0, frame.height/10, frame.width, frame.height*3/5)
        itemImageView.contentMode = .ScaleAspectFit
        self.addSubview(itemImageView)
        itemTitleLabel.frame = CGRectMake(0, frame.height*7/10, frame.width, frame.height/5)
        itemTitleLabel.textColor = UIColor.darkGrayColor()
        itemTitleLabel.textAlignment = .Center
        itemTitleLabel.font = UIFont.systemFontOfSize(13)
        
        self.addSubview(itemTitleLabel)
        let tapGr = UITapGestureRecognizer(target: self, action: "itemSelected")
        self.addGestureRecognizer(tapGr)
    }
    
    func itemSelected(){
        let rawItem = belongedVC.tabBarMoreItems[belongedVC.currentIndex]
        rawItem.itemImageView.image = belongedVC.itemImages[belongedVC.currentIndex]
        rawItem.itemTitleLabel.textColor = UIColor.darkGrayColor()
        
        let image = itemImageView.image?.rt_tintedImageWithColor(UIColor.greenColor())
        itemImageView.image = image
        itemTitleLabel.textColor = UIColor.greenColor()
        belongedVC.currentIndex = self.tag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
