//
//  ActiviyRateViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ActiviyRateViewController: MoreTabViewController {
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var activityRateView: UIView!
    @IBOutlet weak var activityHouseView: UIView!
    @IBOutlet weak var wholeHouseView: UIView!
    
    @IBOutlet weak var dataView: LineAndBarChartView!
    var isYear = true
    var items = [
        LineAndBarItem(dateStr: "2012", activityAccount: 1000, wholeAccount: 3500),
        LineAndBarItem(dateStr: "2013", activityAccount: 2000, wholeAccount: 3000),
        LineAndBarItem(dateStr: "2014", activityAccount: 900, wholeAccount: 3090),
        LineAndBarItem(dateStr: "2015", activityAccount: 1000, wholeAccount: 2000),
        LineAndBarItem(dateStr: "2016", activityAccount: 2500, wholeAccount: 4000)]
    var monthItems = [
        LineAndBarItem(dateStr: "一月", activityAccount: 2000, wholeAccount: 3500),
        LineAndBarItem(dateStr: "二月", activityAccount: 1000, wholeAccount: 3000),
        LineAndBarItem(dateStr: "三月", activityAccount: 200, wholeAccount: 3090),
        LineAndBarItem(dateStr: "四月", activityAccount: 1500, wholeAccount: 2000),
        LineAndBarItem(dateStr: "五月", activityAccount: 3500, wholeAccount: 4000)]
    override func viewDidLoad() {
        super.viewDidLoad()
        yearButton.backgroundColor = headerBgColor
        monthButton.backgroundColor = UIColor.clearColor()
        monthButton.setBorder(UIColor.darkGrayColor())
        activityRateView.backgroundColor = UIColor.clearColor()
        activityRateView.layer.cornerRadius = activityRateView.frame.width/2
        activityRateView.clipsToBounds = true
        activityRateView.layer.borderWidth = 4
        activityRateView.layer.borderColor = UIColor.hex("#557c80").CGColor
        activityHouseView.backgroundColor = headerBgColor
        activityHouseView.setRadius(activityHouseView.frame.width/2)
        wholeHouseView.backgroundColor = UIColor.hex("#399691")
        wholeHouseView.setRadius(wholeHouseView.frame.width/2)
        view.backgroundColor = mainBgColor
        
        view.layoutAllSubViews()
        dataView.xTitle = "年"
        dataView.drawLinesAndBars(items, rateColor: UIColor.hex("#557c80"), wholeAccountColor: UIColor.hex("#399691"), activityAccountColor: headerBgColor)
    }
    @IBAction func yearAction(sender: UIButton) {
        if !isYear{
            sender.backgroundColor = headerBgColor
            sender.setTitleColor(UIColor.whiteColor())
            sender.setBorder(UIColor.clearColor())
            monthButton.backgroundColor = UIColor.clearColor()
            monthButton.setBorder(UIColor.darkGrayColor())
            monthButton.setTitleColor(UIColor.darkGrayColor())
            isYear = true
            dataView.cleanSubViewsAndLayers()
            dataView.xTitle = "年"
            dataView.drawLinesAndBars(items, rateColor: UIColor.hex("#557c80"), wholeAccountColor: UIColor.hex("#399691"), activityAccountColor: headerBgColor)
        }
    }
    @IBAction func monthAction(sender: UIButton) {
        if isYear{
            sender.backgroundColor = headerBgColor
            sender.setTitleColor(UIColor.whiteColor())
            sender.setBorder(UIColor.clearColor())
            yearButton.backgroundColor = UIColor.clearColor()
            yearButton.setBorder(UIColor.darkGrayColor())
            yearButton.setTitleColor(UIColor.darkGrayColor())
            isYear = false
            dataView.cleanSubViewsAndLayers()
            dataView.xTitle = "月"
            dataView.drawLinesAndBars(monthItems, rateColor: UIColor.hex("#557c80"), wholeAccountColor: UIColor.hex("#399691"), activityAccountColor: headerBgColor)
        }
    }
}
