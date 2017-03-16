//
//  ViewController.swift
//  wifiDemo
//
//  Created by zm004 on 16/6/28.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "wifi", style: .Plain, target: self, action: #selector(ViewController.wifiName))
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func wifiName(){
        let wifiName = Wifi.getWifiName()
        print(wifiName)
    }
}

