//
//  PictureCollectionViewController.swift
//  ScoreManager
//
//  Created by zm004 on 16/4/18.
//  Copyright © 2016年 zm002. All rights reserved.
//

import UIKit
import AssetsLibrary
private let reuseIdentifier = "Cell"

class PictureCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate{
    var wholeImages = [UIImage]()
    var images = [NSURL]()
    let assetsLibrary = ALAssetsLibrary()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "相机胶卷"
        collectionView.backgroundColor = UIColor.whiteColor()
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = (UIScreen.mainScreen().bounds.width-25)/4

        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth)
        
        flowLayout.minimumInteritemSpacing = 5

        collectionView.dataSource = self
        collectionView.delegate = self

        
        setupAllImages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAllImages(){

        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group, b) -> Void in
            if group != nil{
                
                let g = String(format: "%@", group)
                
                let g1 = (g as NSString).substringFromIndex(16)
                
                let arr = g1.componentsSeparatedByString(",")
                var g2 = (arr[0] as NSString).substringFromIndex(5)
                
                if g2 == "Camera Roll"{
                    g2 = "相机胶卷"
                
                group.enumerateAssetsUsingBlock({ (asset, index, stop) -> Void in
                    if (asset != nil){
                        if let assetStr = asset.valueForProperty(ALAssetPropertyType) as? String{
                            if assetStr == ALAssetTypePhoto{
                                let urlstr = asset.defaultRepresentation().url()
                                self.images.append(urlstr)
                                
                                if group.numberOfAssets() == self.images.count{
                                    self.collectionView.reloadData()
                                }
                                
                            }
                        }
                    }
                })
                    self.collectionView?.reloadData()
                }
            }else{
                print(b)
            }
            }) { (error) -> Void in
        }
    }

//            self.wholeImages.append(UIImage(CGImage: asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue()))
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count+1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cameraCell", forIndexPath: indexPath) as! CameraCell
            cell.belongedVC = self
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PictureCollectionCell
        cell.data = images[indexPath.row-1]
        return cell
    }
    func cameraAction(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let vc = UIImagePickerController()
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
            })
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: {
            var image = info[UIImagePickerControllerOriginalImage] as! UIImage
            image = self.imageByScalingToMaxSize(image)
            
            let imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.Square)
            imageCropVC.delegate = self;
            self.presentViewController(imageCropVC, animated: true, completion:nil)
        })
        
    }
}
