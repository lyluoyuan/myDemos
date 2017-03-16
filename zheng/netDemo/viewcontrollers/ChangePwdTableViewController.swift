//
//  ChangePwdTableViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ChangePwdTableViewController: UITableViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var rawPwdTextField: FloatLabelTextField!
    @IBOutlet weak var newPwdTextField: FloatLabelTextField!
    @IBOutlet weak var reNewPwdTextField: FloatLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改密码"
        tableView.configStyle()
        tableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        tableView.separatorStyle = .None
        rawPwdTextField.configLeftView("")
        newPwdTextField.configLeftView("")
        reNewPwdTextField.configLeftView("")
        nextButton.greenStyle()
    }
    
}
