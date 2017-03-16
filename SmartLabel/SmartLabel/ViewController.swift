//
//  ViewController.swift
//  SmartLabel
//
//  Created by zm004 on 16/7/1.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var smartTextView: YYTextView!
    @IBOutlet weak var smartLabel: UILabel!
    @IBOutlet weak var textViewheight: NSLayoutConstraint!
//    @IBOutlet weak var textViewWidth: NSLayoutConstraint!

    @IBOutlet weak var testScrollView: UIScrollView!
    @IBOutlet weak var testTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        smartTextView.text = "ad[1]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaaaa[3]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaasdffasdfasdfad[1]asdf[2]aaaasdffasdfasdfad[1]asd"

        
        smartTextView.delegate = self
        view.layoutSubviews()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        smartTextView.setSmartContent("\\[[^\\[|\\]]\\]")
        textViewheight.constant = smartTextView.contentSize.height
    }
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}

