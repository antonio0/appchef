//
//  DataSource.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation

class DataSet {
    
    var _callback: ((String) -> Void)?
    
    var _keys: [String] = []
    
    var data: [[String: String]] = []
    
    init (id: Int, name: String, API: String, keys: [String]) {
        _keys = keys
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