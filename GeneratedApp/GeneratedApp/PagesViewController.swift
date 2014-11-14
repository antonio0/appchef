//
//  PageViewController.swift
//  MyApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var _id = -1
   
    var mainViewController: UIViewController?
    var appDelegate: AppDelegate?
    var Elements: ElementsCollection?

    // basically the initialiser
    func setId(id: Int) {
        self._id = id
        Elements = ElementsCollection(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        mainViewController = appDelegate!.mainViewController
        
//        var bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64))
//        var item = UINavigationItem(title: "main")
//        self.view.addSubview(bar)
//
//        bar.pushNavigationItem(item, animated: false)
//
//        var next = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "test")
//        item.rightBarButtonItem = next
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func test () {
        println("clicked")
    }
    
    
    
    func addList(id: Int, source: Int) {
        
        var newList = appDelegate!.Lists!.create(id, viewController: self, source: source)
        
        let dataSource = appDelegate!.DataSets?.getDataSet(source)
        newList.setDataSet(dataSource!)
        
        newList.view.center = self.view.center;
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

