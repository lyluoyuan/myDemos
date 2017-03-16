//
//  RightPswTextField.swift
//  ScoreManager
//
//  Created by zm004 on 16/4/1.
//  Copyright © 2016年 zm002. All rights reserved.
//

import UIKit

class RightPswTextField: FloatLabelTextField {
    var passwordRightView : UIImageView!
    var eyeOpen = true
    override func awakeFromNib() {
        super.awakeFromNib()
        passwordRightView = UIImageView(image: UIImage(named: "iconfont-eye"))
        passwordRightView.frame = CGRectMake(0, 0, 40, 20)
        passwordRightView.contentMode = .Left
        passwordRightView.addGestureTapAction("eyeAction", target: self)
        self.rightView = passwordRightView
        self.rightViewMode = .Always
    }
    func eyeAction(){
        eyeOpen = !eyeOpen
        if eyeOpen{
            passwordRightView.image = UIImage(named: "iconfont-eye")
            self.secureTextEntry = true
        }else{
            passwordRightView.image = UIImage(named: "iconfont-eyecls")
            self.secureTextEntry = false
        }
        
    }
}
