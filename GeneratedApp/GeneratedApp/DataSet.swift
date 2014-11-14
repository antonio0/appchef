//
//  DataSource.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import Alamofire

class DataSet {
    
    var _callback: ((String) -> Void)?
    
    var _keys: [String] = []
    
    var _API: ExternalAPI?
    
    var data: [[String: String]] = []
    
    init (id: Int, name: String, API: String, keys: [String]) {
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
    }
    
    func add (row: [String: String]) {
        data.append(row)
        if _callback != nil {
            _callback!("")
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