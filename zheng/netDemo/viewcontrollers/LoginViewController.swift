//
//  LoginViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPswLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var pwdPasswordTextField: RightPswTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        view.backgroundColor = mainBgColor
        loginButton.greenStyle()
        forgetPswLabel.textColor = headerBgColor
        forgetPswLabel.addGestureTapAction("switchToForgetPwdVC", target: self)
        
        phoneTextField.configLeftView("")
        pwdPasswordTextField.configLeftView("")
    }
    func switchToForgetPwdVC(){
        let forgetPwdVC = mainStoryboard.instantiateViewControllerWithIdentifier("ForgetPwdTableViewController") as! ForgetPwdTableViewController
        self.navigationController?.pushViewController(forgetPwdVC, animated: true)
    }
    @IBAction func loginAction(sender: UIButton) {
        let regionVC = mainStoryboard.instantiateViewControllerWithIdentifier("RegionViewController") as! RegionViewController
        regionVC.title = "区域"
        let mediaVC = mainStoryboard.instantiateViewControllerWithIdentifier("MediaReportViewController") as! MediaReportViewController
        mediaVC.title = "媒体报道"
        let messageVC = mainStoryboard.instantiateViewControllerWithIdentifier("MessageViewController") as! MessageViewController
        messageVC.title = "消息"
        let acountVC = AcountTableViewController()
        acountVC.title = "账户"
        let slideVC = SlideViewController(viewControllers: [regionVC,mediaVC,messageVC,acountVC])
        slideVC.indicatorColor = headerBgColor
        self.navigationController?.pushViewController(slideVC, animated: true)
    }
}
