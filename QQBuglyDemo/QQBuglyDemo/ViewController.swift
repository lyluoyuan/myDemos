//
//  ViewController.swift
//  QQBuglyDemo
//
//  Created by zm004 on 16/2/5.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import AssetsLibrary
class ViewController: UIViewController {

    @IBOutlet weak var aTextfield: UITextField!
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var aTextView: UITextView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageView: UIImageView!
    


    var images = [NSURL]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let a = [1, 2]
        //        print(a[3])😄

//        🀀
//        MAHJONG TILE EAST WIND
//        Unicode: U+1F000，UTF-8: F0 9F 80 80
//        🀁
//        MAHJONG TILE SOUTH WIND
//        Unicode: U+1F001，UTF-8: F0 9F 80 81
//        aLabel.text = "\u{0001F496}"
//        aTextfield.text = "\u{1F415}"
//        aTextfield.text?.appendContentsOf("\u{e437}")
//        aTextView.text = String("\u{0001F604}")
//        aTextView.keyboardType = .NamePhonePad
        
        NSRegularExpression().rep
        
        let assetsLibrary = ALAssetsLibrary()
        assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group, b) -> Void in
            if group != nil{

                let g = String(format: "%@", group)

                let g1 = (g as NSString).substringFromIndex(16)
                
                let arr = g1.componentsSeparatedByString(",")
                var g2 = (arr[0] as NSString).substringFromIndex(5)
                
                if g2 == "Camera Roll"{
                    g2 = "相机胶卷"
                }
                
                group.enumerateAssetsUsingBlock({ (asset, index, stop) -> Void in
                    if (asset != nil){
                        if let assetStr = asset.valueForProperty(ALAssetPropertyType) as? String{
                            if assetStr == ALAssetTypePhoto{
                                let urlstr = asset.defaultRepresentation().url()
                                
                                self.images.append(urlstr)
                            }
                        }

                    }
                })
            }else{
                print(b)
            }
            }) { (error) -> Void in
        }
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tu"))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tu(){
//        let assetLibrary = ALAssetsLibrary()
//        let url = images[1]
//        
//        assetLibrary.assetForURL(url, resultBlock: { (asset) -> Void in
//            asset.defaultRepresentation().fullResolutionImage()
//            self.imageView.frame = UIScreen.mainScreen().bounds
//            self.imageView.image = UIImage(CGImage: asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue())
//            }) { (error) -> Void in
//        }
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("pictureVC") as! PictureCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

