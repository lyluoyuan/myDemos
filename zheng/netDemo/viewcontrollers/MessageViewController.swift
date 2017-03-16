//
//  MessageViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    var items = [MessageModel(),MessageModel(title: "哈哈哈", content: "hhhhhhhhhhhh", time: "time"),MessageModel(title: "哈哈哈", content: "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", time: "time"),MessageModel(title: "哈哈哈", content: "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh", time: "time")]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configStyle()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        cell.data = items[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("MessageCell", cacheByIndexPath: indexPath, configuration: { (obj) -> Void in
            if let cell = obj as? MessageCell{
                cell.data = self.items[indexPath.row]
            }
        })
    }
}
