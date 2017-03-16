//
//  ViewController.swift
//  chainableAnimationDemo
//
//  Created by zm004 on 16/3/29.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var myVIew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myVIew.rotate()(180).animate()(1.0)
//        myVIew.rotate()(180).anchorTopLeft().spring().thenAfter()(2.0).wait()(2).rotate()(90).anchorCenter().animate()(1.0)
//        let path = myVIew.bezierPathForAnimation()
//        path.addLineToPoint(CGPoint(x: 25, y: 400))
//        path.addLineToPoint(CGPoint(x: 300, y: 500))
//        myVIew.moveOnPath()(path).animate()(0.3)
        
        
//        myVIew.makeConstraint()(self.topConstraint, 300).animate()(1.0)//doesn't work
//        UIView.animateWithDuration(10) { () -> Void in
//            self.topConstraint.constant = 300
//        }
        
        let cuteView = KYCuteView(point: CGPointMake(25, 25), superView: myVIew)
        cuteView.viscosity = 20
        cuteView.bubbleWidth = 35
        cuteView.bubbleColor = UIColor(red: 0, green: 0.772, blue: 1, alpha: 1)
        cuteView.setUp()
//        cuteView.addGesture()
        cuteView.bubbleLabel.text = "13"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

