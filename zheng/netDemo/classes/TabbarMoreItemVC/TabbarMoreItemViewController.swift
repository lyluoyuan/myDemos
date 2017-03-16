//
//  TabbarMoreItemViewController.swift
//  tabbarMoreItemDemo
//
//  Created by zm004 on 16/5/11.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class TabbarMoreItemViewController: UIViewController {
    var viewControllers : [MoreTabViewController]!
    var itemImages : [UIImage]!
    var itemTitles : [String]!
    var addTitles : [String]!
    var currentIndex : Int!
    var contentView : UIView!
    var tabBarMoreItems = [TabbarMoreItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        contentView = UIView(frame: CGRectMake(0,20,view.frame.width,view.frame.height))
        view.addSubview(contentView)
        let tabBar = UIView(frame: CGRectMake(0,view.frame.height-60,view.frame.width,60))
        tabBar.backgroundColor = tabBarColor
        tabBar.layer.borderColor = UIColor.lightGrayColor().CGColor
        tabBar.layer.borderWidth = 0.5
        let itemWidth = screenWidth/CGFloat(viewControllers.count)
        for (index,_) in viewControllers.enumerate(){
            let item = TabbarMoreItem(frame: CGRectMake(CGFloat(index)*itemWidth, 0, itemWidth, tabBar.frame.height))
            item.itemImageView.image = itemImages[index]
            item.itemTitleLabel.text = itemTitles[index]
            item.tag = index
            item.belongedVC = self
            tabBar.addSubview(item)
            tabBarMoreItems.append(item)
        }
        
        view.addSubview(tabBar)
        view.layoutAllSubViews()
        
        currentIndex = 0
        tabBarMoreItems[0].itemSelected()
    }
    func changeCurrentView(){
        contentView.removeAllChildView()
        self.contentView.addSubview(viewControllers[currentIndex].view)
        self.title = "\(itemTitles[currentIndex])(\(addTitles[currentIndex]))"
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}
class MoreTabViewController: UIViewController {
    var moreItemTabBarViewController : TabbarMoreItemViewController!
}