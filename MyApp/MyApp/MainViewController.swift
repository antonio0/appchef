//
//  ViewController.swift
//  MyApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var appDelegate: AppDelegate

    required init(coder decoder: NSCoder) {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        super.init(coder: decoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        // Generate Pages
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

