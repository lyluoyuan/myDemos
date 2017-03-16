//
//  StreetCell.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class StreetCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate{
    var belongedVC : RegionViewController!
    @IBOutlet weak var regionAndStreetTableView: UITableView!

    var isInitial = true
    let keyWindow = UIApplication.sharedApplication().keyWindow
    override func awakeFromNib() {
        super.awakeFromNib()
        regionAndStreetTableView.configStyle()
        regionAndStreetTableView.delegate = self
        regionAndStreetTableView.dataSource = self
        regionAndStreetTableView.separatorStyle = .None
        regionAndStreetTableView.scrollEnabled = false

        // Initialization code
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return belongedVC.regionItems.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let streetItems = belongedVC.streetDic[belongedVC.regionItems[section]]{
            return streetItems.count+1
        }else{
            return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("RegionHeaderCell") as! RegionHeaderCell
            cell.data = belongedVC.regionItems[indexPath.section]
            return cell
        }else{
            if let streetItems = belongedVC.streetDic[belongedVC.regionItems[indexPath.section]]{
                let streetItem = streetItems[indexPath.row-1]
                if streetItem.hasSuffix("Detail"){
                    let cell = tableView.dequeueReusableCellWithIdentifier("TableCommunityCell") as! TableCommunityCell
                    
                    if let communities = belongedVC.communityDic[streetItems[indexPath.row-2]]{
                        cell.data = communities
                    }
                    return cell
                }
                
                let cell = tableView.dequeueReusableCellWithIdentifier("RegionStreetCell") as! RegionStreetCell
                cell.data = streetItem
                if isInitial{
                    cell.downArrowImageView.tag = 10//无下拉Detail
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as? TableCommunityCell{
            
            return CGFloat(cell.items.count*30)
        }
        if let _ = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as? RegionHeaderCell{
            return 21
        }
        if let _ = self.tableView(tableView, cellForRowAtIndexPath: indexPath) as? RegionStreetCell{
            return 41
        }
        return 40
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        isInitial = false
        if indexPath.row != 0{
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? RegionStreetCell{
                let newIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
                var belongedVCShouldReloadData = false
                if cell.downArrowImageView.tag == 10{
                    cell.downArrowImageView.tag = 20//下拉Detail
                    if var streetItems = belongedVC.streetDic[belongedVC.regionItems[indexPath.section]]{
                        
                        let currentItem = streetItems[indexPath.row-1]
                        if let communities = belongedVC.communityDic[currentItem]{
                            streetItems.insert("\(currentItem)Detail", atIndex: indexPath.row-1+1)
                            belongedVC.streetDic[belongedVC.regionItems[indexPath.section]] = streetItems
                            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
                            belongedVCShouldReloadData = true
                            belongedVC.wholeCommunityHeight += CGFloat(communities.count * 30)
                            //                            belongedVC.wholeTableView.reloadData()
                        }
                    }
                }else if cell.downArrowImageView.tag == 20{
                    cell.downArrowImageView.tag = 10//无下拉Detail
                    if var streetItems = belongedVC.streetDic[belongedVC.regionItems[indexPath.section]]{
                        if indexPath.row<streetItems.count{
                            if streetItems[indexPath.row].hasSuffix("Detail"){
                                streetItems.removeAtIndex(indexPath.row-1+1)
                                belongedVC.streetDic[belongedVC.regionItems[indexPath.section]] = streetItems
                                
                                let currentItem = streetItems[indexPath.row-1]
                                if let communities = belongedVC.communityDic[currentItem]{
                                    belongedVC.wholeCommunityHeight -= CGFloat(communities.count * 30)
                                    belongedVCShouldReloadData = true
                                    //                                    belongedVC.wholeTableView.reloadData()
                                }
                                let newIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
                                tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
                            }
                        }
                    }
                }
                
                let downArrowSuperView = cell.downArrowImageView.superview!
                let downArrowSuperViewFrame = keyWindow!.convertRect(keyWindow!.frame, fromView: downArrowSuperView)
                let fakeDownArrowSuperView = UIView()
                fakeDownArrowSuperView.frame.origin = downArrowSuperViewFrame.origin
                fakeDownArrowSuperView.frame.size = downArrowSuperView.frame.size
                fakeDownArrowSuperView.backgroundColor = downArrowSuperView.backgroundColor
                
                let backView = UIView(frame: keyWindow!.frame)
                keyWindow?.addSubview(backView)
                keyWindow?.addSubview(fakeDownArrowSuperView)
                
                let fakeDownArrowImageView = UIImageView(frame: cell.downArrowImageView.frame)
                fakeDownArrowImageView.contentMode = .ScaleAspectFit
                fakeDownArrowImageView.image = cell.downArrowImageView.image
                fakeDownArrowImageView.transform = cell.downArrowImageView.transform
                fakeDownArrowSuperView.addSubview(fakeDownArrowImageView)
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    fakeDownArrowImageView.transform = CGAffineTransformRotate(fakeDownArrowImageView.transform, CGFloat(M_PI))
                    cell.downArrowImageView.transform = CGAffineTransformRotate(cell.downArrowImageView.transform, CGFloat(M_PI))
                    }, completion: { (bool) -> Void in
                        if belongedVCShouldReloadData{
                            self.belongedVC.wholeTableView.reloadData()
                        }
                        //                        fakeDownArrowImageView.removeFromSuperview()
                        backView.removeFromSuperview()
                        fakeDownArrowSuperView.removeFromSuperview()
                        //                        tableView.reloadData()
                })
            }
            
        }
    }
}
