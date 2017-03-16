//
//  RegionViewController.swift
//  netDemo
//
//  Created by zm004 on 16/5/3.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class RegionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var wholeTableView: UITableView!
    let wholeSectionItems = ["市","市辖区","街道办"]
    let regionItems = ["武侯区","锦江区","青羊区","高新区","金牛区","龙泉驿区"]
    var streetDic = ["武侯区":["武侯街道办","武侯第二街道办"],"锦江区":["锦江街道办","锦江第二街道办"]]
    let communityDic = ["武侯街道办":["武侯小区","武侯第二小区"],"锦江街道办":["锦江小区","锦江第二小区"]]
    var wholeCommunityHeight : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        wholeTableView.configStyle()
        wholeTableView.separatorStyle = .None
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == wholeTableView{
            return wholeSectionItems.count
        }
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wholeTableView{
            return 2
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == wholeTableView{
            switch wholeSectionItems[indexPath.section]{
                case "市":
                    if indexPath.row == 0{
                        let cell = tableView.dequeueReusableCellWithIdentifier("wholeHeaderCell") as! WholeHeaderCell
                        cell.data = wholeSectionItems[indexPath.section]
                        return cell
                    }
                    let cell = tableView.dequeueReusableCellWithIdentifier("cityCell") as! CityCell
                    return cell
                case "市辖区":
                    if indexPath.row == 0{
                        let cell = tableView.dequeueReusableCellWithIdentifier("wholeHeaderCell") as! WholeHeaderCell
                        cell.data = wholeSectionItems[indexPath.section]
                        return cell
                    }
                    let cell = tableView.dequeueReusableCellWithIdentifier("regionCell") as! RegionCell
                    cell.belongedVC = self
                    cell.setupCollectionViewHeight()
                    return cell
                case "街道办":
                    if indexPath.row == 0{
                        let cell = tableView.dequeueReusableCellWithIdentifier("wholeHeaderCell") as! WholeHeaderCell
                        cell.data = wholeSectionItems[indexPath.section]
                        return cell
                    }
                    let cell = tableView.dequeueReusableCellWithIdentifier("streetCell") as! StreetCell
                    cell.belongedVC = self
                    return cell
                default:
                    break
            }
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == wholeTableView{
            switch wholeSectionItems[indexPath.section]{
                case "市辖区":
                    if indexPath.row == 1{
                        let h = CGFloat(regionItems.count == 0 ? 40 : 40*((regionItems.count-1)/3+1))
                        return h + 8
                    }
                case "街道办":
                    if indexPath.row == 1{
                        var wholeHeight = 0
                        for d in regionItems{
                            var sectionHeight = 31
                            if let streetItems = streetDic[d]{
                                for _ in streetItems{
                                    sectionHeight += 41
                                }
                            }
                            wholeHeight += sectionHeight
                        }
                        return CGFloat(wholeHeight)+wholeCommunityHeight
                    }
                
                default:
                    break
            }
        }
        return 40
    }
}
