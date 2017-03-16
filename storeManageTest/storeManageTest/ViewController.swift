//
//  ViewController.swift
//  storeManageTest
//
//  Created by zm004 on 16/7/12.
//  Copyright © 2016年 zm004. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var a : A?
    var c : C?
    var b : B?
    override func viewDidLoad() {
        super.viewDidLoad()
        a = A()
//        c = C()
        
        b = B()
        a = nil
        
//        a?.printName()
//        a?.unownedPrint()
        
//        c?.sameClosToA = a!.printName
//        a = nil
//        c!.sameClosToA()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
class A :NSObject, RequestHandler {
    var b : B!
    lazy var printName:()->() = {
        [weak self] in
        if let strongSelf = self{
            print("闭包: \(self!.b)")
        }
    }
    lazy var unownedPrint:()->() = {
        [unowned self] in
        print("test")
        print("unowned闭包: \(self.b)")
    }
    override init(){
        super.init()
        b = B()
        b.delegate = self
    }
    func requestFinished() {
        print("协议中的方法")
    }
    deinit{
        print("A deinit")
    }
}
protocol RequestHandler : NSObjectProtocol{
    func requestFinished()
}
class B {
    weak var delegate : RequestHandler!
    deinit{
        print("B deinit")
    }
}
class C {
    var sameClosToA : (()->())!
    init(){}
}