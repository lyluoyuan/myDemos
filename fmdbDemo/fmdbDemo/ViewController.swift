//
//  ViewController.swift
//  fmdbDemo
//
//  Created by zm004 on 16/6/23.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var database : FMDatabase!
    override func viewDidLoad() {
        super.viewDidLoad()
        let testModels = [TestClass(),TestClass()]
        
        let cache = false
        let rootPath = cache ? NSTemporaryDirectory() : NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let dataBasePath = rootPath + "/lyDatabase.db"//作全局，还是不封装了
        database = FMDatabase(path: dataBasePath)
        database.open()
        do{
            let result = try database.executeQuery("select * from test", values: nil)
            while result.next() {
                let model = TestClass(result.resultDictionary())
                print(model.score)
            }
        }catch{
            do {
                try database.executeUpdate("create table test (id integer, userName text, voicePath text, score float)", values: nil)
                for d in testModels{
                    try database.executeUpdate("insert into test (id, userName, voicePath, score) values (?, ?, ?, ?)", values: [d.id,d.userName,d.voicePath,d.score])
                }
            }catch{}
        }
        database.close()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func sqlAction(sender: UIButton) {
        database.open()
        do{
            try database.executeUpdate("drop table test", values: nil)
            database.close()
        }catch{}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
class TestClass: NSObject {
    var id = 5
    var userName = "userName"
    var voicePath = "voicePath"
    var score = 1.0
    init(_ dic:[NSObject:AnyObject]) {
        let json = JSON(dic)
        id = json["id"].intValue
        userName = json["userName"].stringValue
        voicePath = json["voicePath"].stringValue
        score = json["score"].doubleValue
    }
    override init() {
        super.init()
    }
}
