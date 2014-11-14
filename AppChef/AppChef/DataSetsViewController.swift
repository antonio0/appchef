//
//  SideTableViewController.swift
//  AppChef
//
//  Created by Mark on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class DataSetsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataSetsCollection : DataSetsCollection?
    var appDelegate: AppDelegate?
    
    var addDataSet: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        dataSetsCollection = appDelegate!.dataSetsCollection

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell?
        
        if(cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        
            cell!.textLabel.text = self.appDelegate!.dataSetsCollection!.datasets[indexPath.row].name;
        }
        
            return cell!;
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSetsCollection!.datasets.count
    }
//
}