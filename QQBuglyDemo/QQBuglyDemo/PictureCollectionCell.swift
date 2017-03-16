//
//  PictureCollectionCell.swift
//  QQBuglyDemo
//
//  Created by zm004 on 16/4/20.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import AssetsLibrary
class PictureCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellButton.imageView?.contentMode = .ScaleAspectFill
    }
    var data:NSURL!{
        didSet{
            let assetsLibrary = ALAssetsLibrary()
            assetsLibrary.assetForURL(data, resultBlock: { (asset) -> Void in
                let image = UIImage(CGImage: asset.aspectRatioThumbnail().takeUnretainedValue())
                self.cellButton.setImage(image, forState: UIControlState.Normal)
                }) { (error) -> Void in
            }
        }
    }
}
class CameraCell: UICollectionViewCell {
    var belongedVC : PictureCollectionViewController!
    @IBOutlet weak var cameraButton : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        cameraButton.imageEdgeInsets = UIEdgeInsetsMake(cameraButton.frame.height/5, cameraButton.frame.width*26/100, cameraButton.frame.height/2, 0)
//        cameraButton.titleEdgeInsets = UIEdgeInsetsMake(cameraButton.frame.height*3/5, -cameraButton.frame.width/3, cameraButton.frame.height*1/6, 0)
//        cameraButton.titleLabel?.textAlignment = .Center
    }
    @IBAction func cameraAction(sender: UIButton) {
        self.belongedVC.cameraAction()
    }
}