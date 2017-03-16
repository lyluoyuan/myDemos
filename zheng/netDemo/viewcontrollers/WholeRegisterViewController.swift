//
//  WholeRegisterViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/9.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class WholeRegisterViewController: MoreTabViewController,LineChartViewDelegate,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var pieView: UIView!

    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var otherYearView: UIView!
    @IBOutlet weak var toYearView: UIView!
    @IBOutlet weak var dataView: LineChartView!
    var xStr = [" "]
    var yValues : [Float] = [0.0]
    var monthXstr = ["一月","二月","三月","四月"]
    var monthYValues : [Float] = [10.3,20.1,10.1,40.1]
    @IBOutlet weak var pieTableView: UITableView!
    @IBOutlet weak var pieDataView: PieChartView!
    @IBOutlet weak var pieTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelPieImageView: UIImageView!
    
    var isYear = true
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBgColor
        yearButton.backgroundColor = headerBgColor
        monthButton.backgroundColor = UIColor.clearColor()
        monthButton.setBorder(UIColor.darkGrayColor())
        otherYearView.backgroundColor = headerBgColor
        otherYearView.setRadius(otherYearView.frame.width/2)
        toYearView.backgroundColor = UIColor.hex("#399691")
        toYearView.setRadius(toYearView.frame.width/2)
        
        view.layoutAllSubViews()
        dataView.yTitle = self.moreItemTabBarViewController.addTitles[self.moreItemTabBarViewController.currentIndex]
        self.dataView.xTitle = "年"
        self.dataView.drawView(xStr,yValues: yValues)
        dataView.delegate = self
    }
    @IBAction func selectYearAction(sender: UIButton) {
        if !isYear{
            sender.backgroundColor = headerBgColor
            sender.setTitleColor(UIColor.whiteColor())
            sender.setBorder(UIColor.clearColor())
            monthButton.backgroundColor = UIColor.clearColor()
            monthButton.setBorder(UIColor.darkGrayColor())
            monthButton.setTitleColor(UIColor.darkGrayColor())
            isYear = true
            dataView.cleanSubViewsAndLayers()
            self.dataView.xTitle = "年"
            dataView.drawView(xStr, yValues: yValues)
        }
    }
    @IBAction func selectMonthAction(sender: UIButton) {
        if isYear{
            sender.backgroundColor = headerBgColor
            sender.setTitleColor(UIColor.whiteColor())
            sender.setBorder(UIColor.clearColor())
            yearButton.backgroundColor = UIColor.clearColor()
            yearButton.setBorder(UIColor.darkGrayColor())
            yearButton.setTitleColor(UIColor.darkGrayColor())
            isYear = false
            dataView.cleanSubViewsAndLayers()
            self.dataView.xTitle = "月"
            dataView.drawView(monthXstr, yValues: monthYValues)
        }
    }
    var pieItems = [PieItem(color: UIColor.hex("#008a82"), description: "青羊区", value: 0.1),PieItem(color: UIColor.hex("#557c80"), description: "武侯区", value: 0.1),PieItem(color: UIColor.hex("#9ac34c"), description: "锦江区", value: 0.8)]
    func didSelectPointInLineChartView(index: Int) {
        pieView.backgroundColor = mainBgColor
        pieView.frame = view.bounds
        
        pieTableView.configStyle()
        pieTableView.separatorStyle = .None
        pieTableViewHeightConstraint.constant = CGFloat(pieItems.count*18)
        pieView.layoutAllSubViews()
        
        self.view.addSubview(pieView)
        
        cancelPieImageView.addGestureTapAction("cancelPieViewAction", target: self)
        pieDataView.layer.cleanLayer()
        pieDataView.drawPieChart(pieItems)
    }
    func cancelPieViewAction(){
        pieView.removeFromSuperview()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pieItems.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorStatementCell") as! ColorStatementCell
        cell.data = pieItems[indexPath.row]
        cell.selectionStyle = .None
        cell.backgroundColor = mainBgColor
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 18
    }
}
