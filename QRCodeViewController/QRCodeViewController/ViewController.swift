//
//  ViewController.swift
//  QRCodeViewController
//
//  Created by zm004 on 16/6/2.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", style: UIBarButtonItemStyle.Plain, target: self, action: "push")
    }
    func push(){
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("QRCodeViewController") as! QRCodeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

