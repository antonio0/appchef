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


    // should set this in init
    func setId(id: Int) {
        self._id = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        mainViewController = appDelegate!.mainViewController
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func addLabel(id: Int, text: String) {
        
    }
    
    func addLabel(id: Int, textSoure: String) {
        
    }
    
    
    
    func addList(id: Int, source: Int) {
        
        let listView = ListViewController()
        
        listView.view.center = self.view.center;
        self.addChildViewController(listView)
        self.view.addSubview(listView.view)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

