//
//  DataSource.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import Alamofire
import Parse


class DataSet {
    
    var _callback: ((String) -> Void)?
    
    var _keys: [String] = []
    
    var _API: ExternalAPI?
    
    var data: [[String: String]] = []
    
    var _name: String
    
    var _type : String
    
    init (id: Int, name: String, API: String, keys: [String]) {
        _type = "API"
        _name = ""
        _keys = keys
        _API = ExternalAPI(URI: API)
        _API!.getData({ (result) -> Void in
            println("hi")
            for row in result {
                self.add(row)
            }
            //        DataSets!.getDataSet(0)!.add(["one" : "the", "two": "quick", "three": "brown"])

        })
        
        
    }
    
    init (id: Int, name: String, keys: [String]) {
        _keys = keys
        _type = "parse"
        _name = name
    
        var query = PFQuery(className: name)
        query.findObjectsInBackgroundWithBlock{ (objects: [AnyObject]!, error: NSError!) -> Void in
            for object in objects {
                println("query")
                println(object)
                var row: [String: String] = [:]
                for key in self._keys  {
                    var obj: String! = object[key] as String
                    row[key] = object[key] as String!
                    println( "name:\(obj)")
                }
               self.add2(row );
              
            }
            /*if (error == nil) {
                for object : PFObject! in objects as [PFObject] {
                    println(object)
                    
                }
            }*/
        };

        
    }
    
    func add2 (row: [String: String]) {
        data.append(row)
        if _callback != nil {
            _callback!("")
        }
    }
    
    func add (row: [String: String]) {
        data.append(row)
        if _callback != nil {
            _callback!("")
        }
        
        if _type == "parse"
        {
            //   pull from parse
            println("adding object to parse")
            var newRow = PFObject(className:"\(_name)")
            for key in _keys {
                newRow[key] = row[key]
            }
            println("row")
            println(newRow)
            
            newRow.saveInBackgroundWithBlock({ (result) in
                println("Printing after adding to parse")
                println(result)
            })
        }
    }
    
    func subscribe(callback: (String) -> Void) {
        self._callback = callback
    }
    
    func getRow(row: Int) -> [String: String]? {
        return data[row]
    }
    
    func numItems() -> Int {
        return data.count
    }
    
}