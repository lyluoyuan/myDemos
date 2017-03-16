//
//  FloatLabelTextField.swift
//  FloatLabelFields
//
//  Created by Fahim Farook on 28/11/14.
//  Copyright (c) 2014 RookSoft Ltd. All rights reserved.
//
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Objective-C version by Jared Verdi
//  https://github.com/jverdi/JVFloatLabeledTextField
//

import UIKit

enum FormValidatorRegex {
    case Require
    case Phone
    case Email
    case Int
    case Bank
    case Bank6226
    case None
    case Idcard
    case Other(String,String)
}

@IBDesignable class FloatLabelTextField: UITextField {
	let animationDuration = 0.3
	var title = UILabel()
	
    var errorLabel = UILabel()
    
    var validatorRegex:FormValidatorRegex = .None
    var grayBottomColor = mainBgColor//inputBottomBorderColor
	// MARK:- Properties
	override var accessibilityLabel:String? {
		get {
			if ((text?.isEmpty) != false) {
				return title.text
			} else {
				return text
			}
		}
		set {
			self.accessibilityLabel = newValue
		}
	}
	
//	override var placeholder:String? {
//		didSet {
//			title.text = placeholder
//			title.sizeToFit()
//		}
//	}
//	
//	override var attributedPlaceholder:NSAttributedString? {
//		didSet {
//			title.text = attributedPlaceholder?.string
//			title.sizeToFit()
//		}
//	}
	
	var titleFont:UIFont = UIFont.systemFontOfSize(10) {
		didSet {
			title.font = titleFont
			title.sizeToFit()
		}
	}
	
	@IBInspectable var hintYPadding:CGFloat = 0.0

	@IBInspectable var titleYPadding:CGFloat = 0.0 {
		didSet {
			var r = title.frame
			r.origin.y = titleYPadding
			title.frame = r
		}
	}
	
	@IBInspectable var titleTextColour:UIColor = UIColor.grayColor() {
		didSet {
			if !isFirstResponder() {
				title.textColor = titleTextColour
			}
		}
	}
	
	@IBInspectable var titleActiveTextColour:UIColor! {
		didSet {
			if isFirstResponder() {
				title.textColor = titleActiveTextColour
			}
		}
	}
    
    @IBInspectable var titleText:String? {
        didSet {
            title.text = titleText
            title.sizeToFit()
        }
    }
    
    var isValidate:Bool = true {
        didSet {
            if(isValidate) {
                errorLabel.hidden = true
                layoutSubviews()
            } else {
                errorLabel.hidden = false
                layoutSubviews()
            }
        }
    }
	
	// MARK:- Init
	required init?(coder aDecoder:NSCoder) {
		super.init(coder:aDecoder)
		setup()
	}
	
	override init(frame:CGRect) {
		super.init(frame:frame)
		setup()
	}
	
	// MARK:- Overrides
	override func layoutSubviews() {
		super.layoutSubviews()
		setTitlePositionForTextAlignment()
        
		let isResp = isFirstResponder()
		if isResp && !((text?.isEmpty) != false) {
			title.textColor = titleActiveTextColour
		} else {
			title.textColor = titleTextColour
		}
		// Should we show or hide the title label?
		if ((text?.isEmpty) != false) {
			// Hide
			hideTitle(isResp)
		} else {
			// Show
			showTitle(isResp)
		}
        if !isValidate {
            errorLabel.frame = CGRectMake(0, bounds.size.height-8, bounds.size.width, 8)
            updateOneBorder(UIRectEdge.Bottom,color: redColor)
        } else {
            if isResp {
                updateOneBorder(UIRectEdge.Bottom,color: titleActiveTextColour)
            } else {
                updateOneBorder(UIRectEdge.Bottom,color: grayBottomColor)
            }
        }
        if let border = self.layer.valueForKey("border\(UIRectEdge.Bottom)") as? CALayer {
            border.frame = CGRectMake(border.frame.origin.x, border.frame.origin.y, self.frame.size.width, border.frame.size.height)
        }
	}
	
	override func textRectForBounds(bounds:CGRect) -> CGRect {
		let r = super.textRectForBounds(bounds)
//		if !text.isEmpty {
//			var top = ceil(title.font.lineHeight + hintYPadding)
//			top = min(top, maxTopInset())
//			r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top/2, 0.0, 0.0, 0.0))
//		}
		return CGRectIntegral(r)
	}
	
	override func editingRectForBounds(bounds:CGRect) -> CGRect {
		let r = super.editingRectForBounds(bounds)
//		if !text.isEmpty {
//			var top = ceil(title.bounds.height + hintYPadding)
//			top = min(top, maxTopInset())
//            r = UIEdgeInsetsInsetRect(r, UIEdgeInsetsMake(top/2, 0.0, 0.0, 0.0))
//		}
		return CGRectIntegral(r)
	}
	
	override func clearButtonRectForBounds(bounds:CGRect) -> CGRect {
		var r = super.clearButtonRectForBounds(bounds)
//		if !text.isEmpty {
//			var top = ceil(title.bounds.height + hintYPadding)
//			top = min(top, maxTopInset())
//			r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
//		}
        if self.rightView != nil {
            r = CGRectMake(r.origin.x, r.origin.y - self.rightView!.bounds.size.width, r.size.width, r.size.height)
        }
		return CGRectIntegral(r)
	}
    
	// MARK:- Public Methods
	
	// MARK:- Private Methods
	private func setup() {
		borderStyle = UITextBorderStyle.None
        //		titleActiveTextColour = tintColor
        titleActiveTextColour = textColorGreen
		// Set up title label
		title.alpha = 0.0
		title.font = titleFont
		title.textColor = titleTextColour
//		if let str = placeholder {
//			if !str.isEmpty {
//				title.text = str
//				title.sizeToFit()
//			}
//		}
        self.addSubview(title)
        
        errorLabel.hidden = true
        errorLabel.font = UIFont.systemFontOfSize(10)
        errorLabel.textColor = redColor
        self.addSubview(errorLabel)
        
        addOneBorder(UIRectEdge.Bottom, color: grayBottomColor, borderWidth: 1, borderMargin: 0, offset:0)//lymark -11
	}

	private func maxTopInset()->CGFloat {
		return max(0, floor(bounds.size.height - font!.lineHeight - 4.0))
	}
	
	private func setTitlePositionForTextAlignment() {
		let r = textRectForBounds(bounds)
        var x:CGFloat = 0
		if textAlignment == NSTextAlignment.Center {
			x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
		} else if textAlignment == NSTextAlignment.Right {
			x = r.origin.x + r.size.width - title.frame.size.width
		}
		title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
	}
	
	private func showTitle(animated:Bool) {
        if (titleText == nil || titleText!.isEmpty) {
            return
        }
		let dur = animated ? animationDuration : 0
		UIView.animateWithDuration(dur, delay:0, options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.CurveEaseOut], animations:{
				// Animation
				self.title.alpha = 1.0
				var r = self.title.frame
				r.origin.y = self.titleYPadding
				self.title.frame = r
			}, completion:nil)
	}
	
	private func hideTitle(animated:Bool) {
        if (titleText == nil || titleText!.isEmpty) {
            return
        }
		let dur = animated ? animationDuration : 0
		UIView.animateWithDuration(dur, delay:0, options: [UIViewAnimationOptions.BeginFromCurrentState, UIViewAnimationOptions.CurveEaseIn], animations:{
			// Animation
			self.title.alpha = 0.0
			var r = self.title.frame
			r.origin.y = self.title.font.lineHeight + self.hintYPadding
			self.title.frame = r
			}, completion:nil)
	}
    
    func validateSelf() -> Bool {
        if self.text == nil {
            self.text = ""
        }
        switch validatorRegex {
        case .Require:
            isValidate = (self.text?.isEmpty) == false
            errorLabel.text = "不能为空"
        case .Phone:
            isValidate = valdateForRegex("^[1][0-9]{10}$")
            errorLabel.text = "手机号不正确"
        case .Email:
            isValidate = valdateForRegex("^[a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6}$")
            errorLabel.text = "邮箱不正确"
        case .Int:
            isValidate = valdateForRegex("^[0-9]+$")
            errorLabel.text = "必须为数字"
        case .None:
            isValidate = true
        case .Bank:
            isValidate = NSRegularExpression(pattern: "^\\d{16}$|^\\d{19}$").isMatch(self.text!.stringByReplacingOccurrencesOfString(" ", withString: ""))
            errorLabel.text = "银行卡号为16位或者19位数字"
        case .Bank6226:
            isValidate = NSRegularExpression(pattern: "^\\d{16}$|^\\d{19}$").isMatch("6226"+self.text!.stringByReplacingOccurrencesOfString(" ", withString: ""))
            errorLabel.text = "银行卡号以6226开头的16位或者19位数字"
        case .Idcard:
            isValidate = valdateForRegex("^(\\d{14}|\\d{17})(\\d|[xX])$")
            errorLabel.text = "请输入正确的身份证号"
        case .Other(let regexString,let msg):
            isValidate = valdateForRegex(regexString)
            errorLabel.text = msg
        }
        return isValidate
    }
}
