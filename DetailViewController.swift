//
//  DetailViewController.swift
//  ScoreManager
//
//  Created by zm004 on 16/3/4.
//  Copyright © 2016年 zm002. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView : UITableView!
    

    var lyViews : [NSIndexPath:UIView]!
    let lyExtenCellReuseIdentifier = "lyExtenCellReuseIdentifier"
    let lyContainerCellReuseIdentifier = "lyContainerCellReuseIdentifier"
    var lyItems = [["报名条件", "活动说明", "报名规则", "薪资说明", "考核说明"]]
    var extenCellIndexPaths = [NSIndexPath:NSIndexPath]()
    var containerIndexPaths = [NSIndexPath:NSIndexPath]()
    var imageIndexPaths = [NSIndexPath:UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "绿色地球"
        setHeaderTitle(self.title!, nil)
        tableView.configStyle()
        if !view.subviews.contains(tableView){
            view.addSubview(tableView)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: lyExtenCellReuseIdentifier)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: lyContainerCellReuseIdentifier)
        
        
        for (index,value) in lyItems.enumerate(){
            for (i,_) in value.enumerate(){
                let indexPath = NSIndexPath(forRow: i, inSection: index)
                extenCellIndexPaths[indexPath] = indexPath
            }
        }
        
        let view1 = UIView(frame: CGRectMake(0,0,view.frame.width,20))
        let view2 = UIView(frame: CGRectMake(0,0,view.frame.width,40))
        let view3 = UIView(frame: CGRectMake(0,0,view.frame.width,60))
        let view4 = UIView(frame: CGRectMake(0,0,view.frame.width,60))
        let view5 = UIView(frame: CGRectMake(0,0,view.frame.width,60))
        view1.backgroundColor = UIColor.redColor()
        view2.backgroundColor = UIColor.greenColor()
        view3.backgroundColor = UIColor.blueColor()
        view4.backgroundColor = UIColor.blueColor()
        view5.backgroundColor = UIColor.blueColor()
        lyViews = [NSIndexPath(forRow: 0, inSection: 0):view1,NSIndexPath(forRow: 1, inSection: 0):view2,NSIndexPath(forRow: 2, inSection: 0):view3,NSIndexPath(forRow: 3, inSection: 0):view4,NSIndexPath(forRow: 4, inSection: 0):view5]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.tableView{
            return lyItems.count
        }
        return 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            var count = lyItems[section].count
            for d in containerIndexPaths.keys{
                if d.section == section{
                    count++
                }
            }
            return count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.tableView{
            if extenCellIndexPaths.keys.contains(indexPath){
                let cell = tableView.dequeueReusableCellWithIdentifier(lyExtenCellReuseIdentifier, forIndexPath: indexPath) as! DetailCell
                
                let realIndexPath = extenCellIndexPaths[indexPath]
                imageIndexPaths[realIndexPath!] = cell.arrowImageView
                cell.itemLabel?.text = lyItems[realIndexPath!.section][realIndexPath!.row]
                return cell
            }else if containerIndexPaths.keys.contains(indexPath){
                let cell = tableView.dequeueReusableCellWithIdentifier(lyContainerCellReuseIdentifier, forIndexPath: indexPath)
                if let lyView = lyViews[containerIndexPaths[indexPath]!]{
                    let containerView = lyView
                    for d in cell.contentView.subviews{
                        d.removeFromSuperview()
                    }//lymark
                    cell.contentView.addSubview(containerView)
                    cell.frame = containerView.frame
                    cell.userInteractionEnabled = false
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView  == self.tableView{
            
            let newIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
            var maxIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            //                extenCellIndexPaths[newIndexPath] = nil
            for (index,_) in extenCellIndexPaths{
                if index.section > maxIndexPath.section || (index.section == maxIndexPath.section && index.row > maxIndexPath.row){
                    maxIndexPath = index
                }
            }
            if containerIndexPaths[newIndexPath] == nil{

             
                for var s = maxIndexPath.section; s >= 0; s-- {
                    for var r = maxIndexPath.row; r >= 0; r-- {
                        if s > indexPath.section || (s == indexPath.section && r > indexPath.row){
                            extenCellIndexPaths[NSIndexPath(forRow: r + 1, inSection: s)] = extenCellIndexPaths[NSIndexPath(forRow: r, inSection: s)]
                            extenCellIndexPaths[NSIndexPath(forRow: r, inSection: s)] = nil
                        }
                    }
                }
                containerIndexPaths[newIndexPath] = extenCellIndexPaths[indexPath]
                for (index,value) in containerIndexPaths{
                    if index.section > newIndexPath.section || (index.section == newIndexPath.section && index.row > newIndexPath.row){
                        containerIndexPaths[index] = nil
                        containerIndexPaths[NSIndexPath(forRow: index.row + 1, inSection: index.section)] = value
                    }
                }
                
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            }else{
                
                for s in 0...maxIndexPath.section{
                    for r in 0...maxIndexPath.row{
                        if s > newIndexPath.section || (s == newIndexPath.section && r > newIndexPath.row){
                            extenCellIndexPaths[NSIndexPath(forRow: r - 1, inSection: s)] = extenCellIndexPaths[NSIndexPath(forRow: r, inSection: s)]
                            extenCellIndexPaths[NSIndexPath(forRow: r, inSection: s)] = nil
                        }
                    }
                }
                containerIndexPaths[newIndexPath] = nil
                for (index,value) in containerIndexPaths{
                    if index.section > indexPath.section || (index.section == indexPath.section && index.row > indexPath.row){
                        containerIndexPaths[index] = nil
                        containerIndexPaths[NSIndexPath(forRow: index.row - 1, inSection: index.section)] = value
                    }
                }
                
                //                for d in extenCellIndexPaths.keys{
                //                    print("cell: \(d.row)")
                //                }
                //                for d in containerIndexPaths.keys{
                //                    print("container: \(d.row)")
                //                }
                tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            }
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                let imageView = self.imageIndexPaths[self.extenCellIndexPaths[indexPath]!]
                imageView?.transform = CGAffineTransformRotate(imageView!.transform,CGFloat(M_PI))
            })
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == self.tableView{
            if containerIndexPaths.keys.contains(indexPath){
                if let lyView = lyViews[containerIndexPaths[indexPath]!]{
                    return lyView.frame.height
                }
            }
            return 62
        }
        return 40
    }
}
