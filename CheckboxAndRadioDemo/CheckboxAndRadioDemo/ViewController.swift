//
//  ViewController.swift
//  checkBoxAndRadioDemo
//
//  Created by zm004 on 16/3/22.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var radioButton: LYRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButton.selectStatus = true
        radioButton.setTitle("asdfasdfasdfadsfdsagasgasdgasgasgasgagasfgasdgdasgzxcvzvcxvasdfasdfasdfadsfdsagasgasdgasgasgasgagasfgasdgdasgzxcvzvcxvasdfasdfasdfadsfdsagasgasdgasgasgasgagasfgasdgdasgzxcvzvcxvasdfasdfasdfadsfdsagasgasdgasgasgasgagasfgasdgdasgzxcvzvcxvasdfasdfasdfadsfdsagasgasdgasgasgasgagasfgasdgdasgzxcvzvcxv", forState: UIControlState.Normal)
        radioButton.layer.borderWidth = 3
        radioButton.layer.borderColor = UIColor.blackColor().CGColor
        
        print(radioButton.imageView?.frame)
        print(radioButton.titleLabel?.frame)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

