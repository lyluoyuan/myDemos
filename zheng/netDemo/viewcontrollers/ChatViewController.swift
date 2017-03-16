//
//  ChatViewController.swift
//  ScoreManager
//
//  Created by 邝利军 on 15/7/26.
//  Copyright (c) 2015年 zm002. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
                ,STBubbleTableViewCellDataSource,STBubbleTableViewCellDelegate,UITextFieldDelegate,CustomEmojiViewDelegate{

    var items = [DmsModel]()
    
    var contactsModel:ConstactsModel!
    var contentText = ""
    @IBOutlet weak var viewToTableView: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contentTextField: UITextField!

    let defualtReusableCellIdentifier = "cell"
    var maxId = 0
    var minId = Int.max
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emojiImageView: UIImageView!
    var emojiView: CustomEmojiView!
    var rawInputView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextField.delegate = self
        contentView.backgroundColor = mainBgColor
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(STBubbleTableViewCell.classForCoder(), forCellReuseIdentifier: defualtReusableCellIdentifier)

//        loadData(false)
        contentTextField.text = contentText
        self.automaticallyAdjustsScrollViewInsets = false//Mark: -bottomInput
        self.edgesForExtendedLayout = UIRectEdge.None
        

        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            self.loadData(false)
        })
        if let header = tableView.mj_header as? MJRefreshNormalHeader {
            header.lastUpdatedTimeLabel!.hidden = true
            header.stateLabel!.hidden = true
        }
        self.title = contactsModel.name
        tableView.mj_header.beginRefreshing()

        self.tableViewHeightConstraint.constant = self.view.frame.size.height - self.navigationController!.navigationBar.frame.size.height - self.contentView.frame.size.height - self.viewToTableView.constant - UIApplication.sharedApplication().statusBarFrame.size.height
        
        emojiImageView.addGestureTapAction("setupEmoji", target: self)
        rawInputView = contentTextField.inputView
    }
    func setupEmoji(){
        
        contentTextField.resignFirstResponder()
        contentTextField.inputView = CustomEmojiView(textField: contentTextField, delegate: self)
        contentTextField.becomeFirstResponder()
    }
    func CustomEmojiViewSendText(text: String) {
        textFieldShouldReturn(contentTextField)
    }
    override func viewDidDisappear(animated: Bool) {
        contentText = ""
        contentTextField.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isFirst = true
    func loadData(isGetNew:Bool) {
        var params = [String:AnyObject]()
        params["user_id"] = contactsModel.id
        if isGetNew {
            params["max_dms_content_id"] = maxId
        } else {
            params["min_dms_content_id"] = minId
        }
        let ajax = Ajax(url: "data/getAdminDmsContentList", params: params, vc: self)
        ajax.success = { json in
            for d in json.items {
                let bean = DmsModel(d)
                self.minId = min(self.minId, bean.dmsContentId)
                self.maxId = max(self.maxId, bean.dmsContentId)
                if isGetNew {
                    self.items.append(bean)
                } else {
                    self.items.insert(bean, atIndex: 0)
                }
            }
            self.tableView.reloadData()
            
            if isGetNew || self.isFirst {
                self.isFirst = false
                var yOffset:CGFloat = 0
                
                if self.tableView.contentSize.height > self.tableView.bounds.size.height {
                    yOffset = self.tableView.contentSize.height - self.tableView.bounds.size.height
                }
                
                self.tableView.setContentOffset(CGPointMake(0, yOffset), animated: false)
            }
        }
        
        ajax.callback = { json in
            self.tableView.mj_header.endRefreshing()
        }
        ajax.hud = false
        ajax.post()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(defualtReusableCellIdentifier, forIndexPath: indexPath) as! STBubbleTableViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        
        let data = items[indexPath.row]
        cell.textLabel?.text = data.dmsContent
        cell.timeLabel.text = data.dmsContentTimeCreate
        
//        cell.imageView?.zm_setImageUrl(contactsModel.dms, defaultImage: self)
        
        if data.flgMe == 0 {
            cell.authorType = AuthorType.STBubbleTableViewCellAuthorTypeOther
            cell.bubbleColor = BubbleColor.STBubbleTableViewCellBubbleColorGray
            cell.imageView?.zm_setImageUrl(contactsModel.avatar)
        } else {
            cell.authorType = AuthorType.STBubbleTableViewCellAuthorTypeSelf
            cell.bubbleColor = BubbleColor.STBubbleTableViewCellBubbleColorGreen
            cell.imageView?.zm_setImageUrl(appUser.avatar)
        }
        cell.imageView!.layer.cornerRadius = STBubbleImageSize/2
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if contentTextField.text!.isEmpty {
            return true
        }
        self.contentTextField.resignFirstResponder()
        let ajax = Ajax(url: "data/createAdminDmsContent", params: ["user_id":contactsModel.id,"dms_content":contentTextField.text!], vc: self)
        ajax.success = { json in
            self.contentTextField.text = ""
            self.loadData(true)
        }
        ajax.post()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == contentTextField{
            textField.inputView = rawInputView
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
