//
//  PieChartViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class PieChartViewController: MoreTabViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var pieItems = [PieItem(color: UIColor.hex("#008a82"), description: "青羊区", value: 0.1),PieItem(color: UIColor.hex("#557c80"), description: "武侯区", value: 0.1),PieItem(color: UIColor.hex("#9ac34c"), description: "锦江区", value: 0.8)]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configStyle()
        tableView.separatorStyle = .None
        view.backgroundColor = mainBgColor
        tableViewHeightConstraint.constant = CGFloat(pieItems.count*18)
        
        view.layoutAllSubViews()
        pieChartView.drawPieChart(pieItems)
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
