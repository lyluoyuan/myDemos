//
//  RegionCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class RegionCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var regionCollectionView: UICollectionView!
    var belongedVC:RegionViewController!
    @IBOutlet weak var collectionViewConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        regionCollectionView.dataSource = self
        regionCollectionView.delegate = self
        
        let itemHeight = CGFloat(40*0.8)
        let itemWidth = (self.frame.width-4*30)/3
        
        let flowLayout = regionCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        flowLayout.minimumInteritemSpacing = 30
    }
    func setupCollectionViewHeight(){
        collectionViewConstraint.constant = CGFloat(belongedVC.regionItems.count == 0 ? 40 : 40*((belongedVC.regionItems.count-1)/3+1))
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return belongedVC.regionItems.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("regionCollectionCell", forIndexPath: indexPath) as! RegionCollectionCell
        cell.data = belongedVC.regionItems[indexPath.row]
        return cell        
    }
}
