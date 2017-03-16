//
//  ZMExTableView.swift
//  ScoreManager
//
//  Created by zm002 on 15/4/10.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

extension UIScrollView {
//    func configRefreshHeaderGif() {
//        var images = [UIImage]()
//        for i in 1...33 {
//            let index = String(format: "%02d", i)
//            images.append(UIImage(named: "refresh_\(index)")!)
//        }
//        self.gifHeader.setImages(images, forState: MJRefreshHeaderStateIdle)
//        self.gifHeader.setImages(images, forState: MJRefreshHeaderStatePulling)
//        self.gifHeader.setImages(images, forState: MJRefreshHeaderStateRefreshing)
//        
////        self.gifFooter.refreshingImages = images
//        
//        self.header.updatedTimeHidden = true
//        self.header.stateHidden = true
//    }
}

extension UITableView {
    
    func configStyle() {
        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        self.backgroundColor = mainBgColor
        
        self.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func dismissSelectedStyle (indexPath:NSIndexPath) {
        self.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func getComputeCellHeight(cell:UITableViewCell) -> CGFloat {
        let tempWidthConstraint = NSLayoutConstraint(item: cell.contentView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: screenWidth)
        cell.contentView.addConstraint(tempWidthConstraint)
        
        let fittingSize = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        
        var sparatorHeight:CGFloat = 0
        if self.separatorStyle != .None {
            sparatorHeight = CGFloat(1.0 / UIScreen.mainScreen().scale)
        }
        
        return fittingSize.height + sparatorHeight
    }
    
    
}

extension UITableViewCell {
    
    func configStyle() {
//        self.backgroundColor = UIColor.hex( "#f0f0f0")
        
    }
    
    func setSeperateLineFill() {
        if self.respondsToSelector("setSeparatorInset:") {
            self.separatorInset = UIEdgeInsetsZero
        }
        if #available(iOS 8.0, *) {
            self.layoutMargins = UIEdgeInsetsZero
            self.preservesSuperviewLayoutMargins = false
        }
    }
    
    func renderNoneSelectedStyle() {
        let v = UIView()
        v.backgroundColor = UIColor.clearColor()
        self.selectedBackgroundView = v
    }
}