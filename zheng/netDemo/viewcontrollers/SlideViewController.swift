//
//  SlideViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class SlideViewController: JYSlideSegmentController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提问", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SlideViewController.questionAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconfont-cha"), style: .Plain, target: self, action: #selector(SlideViewController.navicancelAction))

    }
    func navicancelAction(){
        let newTabVC = TabbarMoreItemViewController()
        let tabItemTitles = ["总注册","总活动","总投放","回收箱","投放点","活跃率","注册率"]
        var xStrs = [["2011","2013","2015"],["2011","2012","2014"],["2013","2014","2015"],["2014","2015","2016"],["2011","2013","2015"],["2011","2013","2015"],["2011","2013","2015"]]
        var yValues : [[Float]] = [[4.0,10.4,30.8],[2.0,50.4,30.8],[3.0,10.4,20.8],[4.0,10.4,30.8],[4.0,10.4,30.8],[4.0,10.4,30.8],[4.0,10.4,30.8]]
        let units = ["万户","场","吨","个","个","%","%"]
        var viewControllers = [MoreTabViewController]()
        var images = [UIImage]()
        for (index,value) in tabItemTitles.enumerate(){
            if value == "回收箱"{
                let recycleboxVC = mainStoryboard.instantiateViewControllerWithIdentifier("PieChartViewController") as! PieChartViewController
                recycleboxVC.moreItemTabBarViewController = newTabVC
                viewControllers.append(recycleboxVC)
            }else if value == "活跃率"{
                let acivityRateVC = mainStoryboard.instantiateViewControllerWithIdentifier("ActiviyRateViewController") as! ActiviyRateViewController
                acivityRateVC.moreItemTabBarViewController = newTabVC
                viewControllers.append(acivityRateVC)
            }else{
                let vc = mainStoryboard.instantiateViewControllerWithIdentifier("WholeRegisterViewController") as! WholeRegisterViewController
                vc.xStr = xStrs[index]
                vc.yValues = yValues[index]
                vc.moreItemTabBarViewController = newTabVC
                viewControllers.append(vc)
            }
            images.append(UIImage(named: "icon_dataTab\(index)")!)            
        }
        newTabVC.viewControllers = viewControllers
        newTabVC.itemTitles = tabItemTitles
        newTabVC.itemImages = images
        newTabVC.addTitles = units
        self.navigationController?.pushViewController(newTabVC, animated: true)
    }
    func questionAction(){
//        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("chatVC") as! ChatViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
