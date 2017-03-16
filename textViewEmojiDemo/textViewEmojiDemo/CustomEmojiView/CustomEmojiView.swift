//
//  CustomEmojiView.swift
//  textViewEmojiDemo
//
//  Created by zm004 on 16/4/25.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height
protocol CustomEmojiViewDelegate{
    func CustomEmojiViewSendText(text:String)
}
class CustomEmojiView: UIView,UICollectionViewDataSource,UICollectionViewDelegate{
    var emojis : [String:[String]]!
    var subTitles = [String]()
    var textView : UITextView!
    var delegate : CustomEmojiViewDelegate!
    var rawInputView : UIView!
    var pageControl : UIPageControl!
    var collectionView : UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    init(textView:UITextView!,delegate:CustomEmojiViewDelegate!){
        super.init(frame: CGRectZero)
        rawInputView = textView.inputView
        
        self.textView = textView
        self.frame = CGRectMake(0,0,screenWidth,515/1334*screenHeight)
        self.backgroundColor = UIColor.lightGrayColor()//e9ecec
        
        let itemHeight = self.frame.height/6.5
        let itemWidth = (self.frame.width)/9
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        collectionView = UICollectionView(frame: CGRectMake(0, itemHeight/2, screenWidth, itemHeight*5), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self

        let plistPath = NSBundle.mainBundle().pathForResource("EmojisList", ofType: "plist")
        emojis = NSDictionary(contentsOfFile: plistPath!) as! [String:[String]]
        for d in emojis.keys{
            subTitles.append(d)
        }
        subTitles.removeAtIndex(subTitles.indexOf("People")!)
        subTitles.insert("People", atIndex: 0)
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = UIColor.lightGrayColor()
        collectionView.reloadData()
        self.addSubview(collectionView)
        
        let sendBtn = UIButton(type: .Custom)
        sendBtn.frame = CGRectMake(screenWidth-50, itemHeight*(5.5+0.2), 50, itemHeight*4/5)
        sendBtn.setTitle("发送", forState: UIControlState.Normal)
        sendBtn.addTarget(self, action: "sendAction", forControlEvents: UIControlEvents.TouchUpInside)
        sendBtn.greenlineBorder()//greenstyle
        self.addSubview(sendBtn)
        
        let delBtn = UIButton(type: .Custom)
        delBtn.frame = CGRectMake(screenWidth-105, itemHeight*5.7, 50, itemHeight*4/5)
        delBtn.setTitle("删除", forState: UIControlState.Normal)
        delBtn.addTarget(self, action: "deleteAction", forControlEvents: UIControlEvents.TouchUpInside)
        delBtn.greenlineBorder()
        self.addSubview(delBtn)
        
        let rawBtn = UIButton(type: .Custom)
        rawBtn.frame = CGRectMake(0, itemHeight*5.7, 50, itemHeight*4/5)
        rawBtn.setTitle("ABC", forState: .Normal)
        rawBtn.addTarget(self, action: "ABCAction", forControlEvents: .TouchUpInside)
        rawBtn.greenlineBorder()
        self.addSubview(rawBtn)
        
        self.delegate = delegate
        pageControl = UIPageControl(frame: CGRectMake(60,itemHeight*5.7,100,itemHeight*4/5))
        pageControl.numberOfPages = subTitles.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        self.addSubview(pageControl)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == collectionView{
            let indexPath = collectionView.indexPathForItemAtPoint(scrollView.contentOffset)
            if let section = indexPath?.section{
                pageControl.currentPage = section
            }
        }
    }
    func ABCAction(){
        textView.inputView = rawInputView
        textView.resignFirstResponder()
        textView.becomeFirstResponder()
    }
    func sendAction(){
        delegate.CustomEmojiViewSendText(textView.text)
    }
    func deleteAction(){
        var text = textView.text
        if !text.isEmpty{
            text.removeRange(Range(start: text.endIndex.advancedBy(-1), end: text.endIndex))
            textView.text = text
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return subTitles.count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subArray = emojis[subTitles[section]]! as [String]
        return subArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath)
        for d in cell.contentView.subviews{
            d.removeFromSuperview()
        }
        let label = UILabel(frame: cell.bounds)
        let subArray = emojis[subTitles[indexPath.section]]! as [String]
        label.text = subArray[indexPath.row]
        label.font = UIFont.systemFontOfSize(30)
        label.backgroundColor = UIColor.clearColor()
        cell.contentView.addSubview(label)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let subArray = emojis[subTitles[indexPath.section]]! as [String]
        textView.text.appendContentsOf(subArray[indexPath.row])
    }
}
extension UIButton{
    func greenlineBorder(){
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.greenColor()
//        self.layer.borderColor = UIColor.greenColor().CGColor
//        self.layer.borderWidth = 1
    }
}