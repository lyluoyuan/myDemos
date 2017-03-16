//
//  ViewController.swift
//  SDCircleScrollViewDemo
//
//  Created by zm004 on 16/3/30.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cycleScrollView.imageURLStringsGroup = ["http://pic.to8to.com/attch/day_160218/20160218_d968438a2434b62ba59dH7q5KEzTS6OH.png","http://pic.to8to.com/attch/day_160218/20160218_6410eaeeba9bc1b3e944xD5gKKhPEuEv.png"]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

