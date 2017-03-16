//
//  MediaReportViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/5.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class MediaReportViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var items = [MediaReportModel(),MediaReportModel()]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configStyle()
        tableView.separatorColor = mainBgColor
        // Do any additional setup after loading the view.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MediaReportCell") as! MediaReportCell
        cell.data = items[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("MediaReportCell", cacheByIndexPath: indexPath) { (obj) -> Void in
            if let cell = obj as? MediaReportCell{
                cell.data = self.items[indexPath.row]
            }
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
