//
//  TabbarMoreItemViewController.swift
//  tabbarMoreItemDemo
//
//  Created by zm004 on 16/5/11.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height
class TabbarMoreItemViewController: UIViewController {
    var viewControllers : [UIViewController]!
    var itemImages : [UIImage]!
    var itemTitles : [String]!
    var currentIndex : Int!{
        didSet{
            for d in self.contentView.subviews{
                d.removeFromSuperview()
            }
            self.contentView.addSubview(viewControllers[currentIndex].view)
        }
    }
    var contentView : UIView!
    var tabBarMoreItems = [TabbarMoreItem]()
    override func viewDidLoad() {
        super.viewDidLoad()

        itemImages = [UIImage(named: "icon_dataTab0")!,UIImage(named: "icon_dataTab0")!]//
        itemTitles = ["item","item"]//
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.lightGrayColor()
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.yellowColor()
        viewControllers = [vc1,vc2]//
        
        contentView = UIView(frame: CGRectMake(0,0,view.frame.width,view.frame.height-60))
        view.addSubview(contentView)
        let tabBar = UIView(frame: CGRectMake(0,view.frame.height-60,view.frame.width,60))
        tabBar.backgroundColor = UIColor.lightGrayColor()
        tabBar.layer.borderColor = UIColor.lightGrayColor().CGColor
        tabBar.layer.borderWidth = 0.5
        let itemWidth = screenWidth/CGFloat(viewControllers.count)
        for (index,value) in viewControllers.enumerate(){
            let item = TabbarMoreItem(frame: CGRectMake(CGFloat(index)*itemWidth, 0, itemWidth, tabBar.frame.height))
            item.itemImageView.image = itemImages[index]
            item.itemTitleLabel.text = itemTitles[index]
            item.tag = index
            item.belongedVC = self
            tabBar.addSubview(item)
            tabBarMoreItems.append(item)
        }
        
        view.addSubview(tabBar)
        currentIndex = 0
        tabBarMoreItems[0].itemSelected()        
    }

}
