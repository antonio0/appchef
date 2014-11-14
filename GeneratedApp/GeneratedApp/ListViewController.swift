//
//  ListViewController.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var _dataSet: DataSet?
    
    var Elements = ElementsCollection()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setDataSet(dataSet: DataSet) {
        _dataSet = dataSet
        _dataSet!.subscribe({ (thing) -> Void in
            self.tableView.reloadData()
        })
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        var cell:UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if (cell != nil) {
            println(cell!.textLabel)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._dataSet!.numItems()
    }
    
    //
    //    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
    //        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }

        let row = _dataSet!.getRow(indexPath.row)
        
        var CellElements = ElementsCollection(view: cell!.contentView)
        
        var idcount = 0;
        
        for Obj in Elements.getElements() {
            
            
            var type = Obj["type"] as String?
            
            if type == nil {
                continue
            }
            
            var element: AnyObject? = Obj[type!]
            
            switch (type!) {
                case "UILabel":
                    
                    var dataKey = Obj["source"] as String?
                    
                    if dataKey == nil {
                        continue
                    }
                    
                    element = element as UILabel
                    CellElements.addStaticLabel(idcount, text: row![dataKey!]!)
                    println("adding \(row![dataKey!]!)")
                default:
                1+1
            }
            idcount = idcount + 1;
            
        }
        
        
        //cell!.textLabel.text = row!["name"]
        
        return cell!
    }
    
}