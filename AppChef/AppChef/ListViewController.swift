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
    var appDelegate: AppDelegate?

    var _dataSet: DataSet?
    
    var Elements = ElementsCollection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?

    }
    
    
    var clickActions = [Int: [String: Int]]()

    
    func addAction(id: Int, addToDataSet: Int, itemsToAdd: [String: Int]) {
        
        var bugitemsToAdd = itemsToAdd
        
        println("doing this shizzlef for \(id)")
        let elementDict = Elements.getElement(id)
        if elementDict == nil {
            return
        }
        
        let type = elementDict!["type"] as String
        var element: AnyObject? = elementDict![type]
        
        switch (type) {
        case "UIButton":
            var btn = element as UIButton
//            btn.tag = addToDataSet
            println("sadadasdasd this shizzlef for \(id)")
            bugitemsToAdd.updateValue(addToDataSet, forKey: "addToDataSet")
            clickActions[id] = bugitemsToAdd
            
            
//            btn.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
            
        default:
            1+1
            
        }
        
        self.tableView.reloadData()
        
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    
    func elTouched(sender: AnyObject?) {
        println("touched \(sender!.tag)")
        
        var actions = clickActions[sender!.tag]
        var modelIdToAdd = actions!["addToDataSet"]
        println(actions)
        
        var row: [String: String] = [:]
        
        for target in actions!.keys {
            if target == "addToDataSet" {
                continue
            }
        
            var targetElm = sender!.superview!!.viewWithTag(actions![target]!)
            
            if targetElm is UILabel {
                var labelToAdd = targetElm as UILabel
                row[target] = labelToAdd.text
            }
            
            
        }
        
        var modelToAdd = appDelegate!.DataSets!.getDataSet(modelIdToAdd!)
        modelToAdd!.add(row)
        
        println(row)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        

        let row = _dataSet!.getRow(indexPath.row)
        
        var CellElements = ElementsCollection(view: cell!.contentView)
        
        var idcount = 0;
        
        for key in Elements._elements.keys {
            let Obj = Elements._elements[key]!
            
            
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
                    CellElements.addStaticLabel(key, text: row![dataKey!]!, size: element!.frame)
                    println("adding \(row![dataKey!]!)")
                
                case "UIImageView":
                    
                    var dataKey = Obj["source"] as String?
                    
                    if dataKey == nil {
                        continue
                    }
                    
                    element = element as UIImageView
                    CellElements.addStaticImage(idcount, url: row![dataKey!]!, size: element!.frame)
                    println("adding \(row![dataKey!]!)")

                case "UIButton":
                    
                    var dataText = Obj["text"] as String?
                    element = element as UIButton
                    println(Obj["text"])
                    if dataText != nil {
                        println("adding \(dataText!)")
                        CellElements.addStaticButton(idcount, text: dataText!, size: element!.frame)
                    }
                
                default:
                1+1
            }
            
            let potentialAction = clickActions[key]
            
            if potentialAction != nil {
                println("action found")
                println("Adding clicky to \(idcount)")
                let elm = CellElements.getElement(idcount)
                let type = elm!["type"] as String?
                var element = elm![type!]! as UIButton
                element.tag = key
                element.addTarget(self, action: "elTouched:", forControlEvents: .TouchUpInside)
            }
            
            
            
            idcount = idcount + 1;
            
        }
        
        }
        //cell!.textLabel.text = row!["name"]
        cell!.selectionStyle = .None
        return cell!
    }
    
}