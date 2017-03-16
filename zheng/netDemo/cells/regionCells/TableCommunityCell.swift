//
//  TableCommunityCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/5.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class TableCommunityCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource{
    let cellHeight:CGFloat = 30
    @IBOutlet weak var communityTableView: UITableView!
    var items = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        communityTableView.configStyle()
        communityTableView.delegate = self
        communityTableView.dataSource = self
        communityTableView.scrollEnabled = false
        communityTableView.separatorColor = UIColor.lightGrayColor()
        communityTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "communityCell")
        // Initialization code
    }
    var data : [String]!{
        didSet{
            items = data
            communityTableView.reloadData()
            
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("communityCell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.systemFontOfSize(14)
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
}
