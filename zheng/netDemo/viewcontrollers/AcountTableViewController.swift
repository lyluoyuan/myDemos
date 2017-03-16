//
//  AcountTableViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class AcountTableViewController: UITableViewController {
    let items = ["修改密码","退出登录"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configStyle()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch items[indexPath.row]{
            case "退出登录":
            self.navigationController?.popToRootViewControllerAnimated(true)
            case "修改密码":
            let changePwdVC = mainStoryboard.instantiateViewControllerWithIdentifier("ChangePwdTableViewController") as! ChangePwdTableViewController
            self.navigationController?.pushViewController(changePwdVC, animated: true)
            default:
            break
        }
    }
}
