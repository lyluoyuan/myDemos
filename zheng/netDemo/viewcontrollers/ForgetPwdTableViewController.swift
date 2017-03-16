//
//  ForgetPwdTableViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/6.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ForgetPwdTableViewController: UITableViewController {

    @IBOutlet weak var phoneTextField: FloatLabelTextField!
    @IBOutlet weak var verifyCodeTextField: FloatLabelTextField!
    @IBOutlet weak var pwdTextField: RightPswTextField!
    @IBOutlet weak var comfirPwdTextField: RightPswTextField!
    @IBOutlet weak var getVerifyCodeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "忘记密码"
        getVerifyCodeButton.greenStyle()
        phoneTextField.configLeftView("")
        verifyCodeTextField.configLeftView("")
        pwdTextField.configLeftView("")
        comfirPwdTextField.configLeftView("")
        
    }

}
