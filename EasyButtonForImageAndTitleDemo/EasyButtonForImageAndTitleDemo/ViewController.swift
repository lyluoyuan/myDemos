//
//  ViewController.swift
//  EasyButtonForImageAndTitleDemo
//
//  Created by zm004 on 16/7/22.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        testButton.setTitle("123", forState: .Normal)
        print(testButton.aaa)
//        testButton.setTopImage("field_radio_check")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

