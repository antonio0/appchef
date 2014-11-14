//
//  BindElementModelController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class BindElementModelController: UIViewController, UITextFieldDelegate {
    var appDelegate: AppDelegate?
    var bindings: Bindings?
    
    @IBOutlet weak var selectAction: UISegmentedControl!
    @IBOutlet weak var addToDSView: UIView!
    @IBOutlet weak var allBindings: UILabel!
    
    var currDataSource: Int?
    var currElement: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        bindings    = appDelegate!.bindings
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAddAction(sender: AnyObject) {
//        bindings?.addSourceBinding(dataSet: currDS!, el ement: currElement, key: "addToDataSet")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}