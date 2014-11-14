//
//  DataSourceCollection.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit


class PlayDataSetsCollection {
    
    var _datasets = [Int: PlayDataSet]()
    
    var appDelegate: AppDelegate
    
    init () {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    }

    func create (id: Int, name: String, API: String, keys: [String]) {
        
        var newDataSet = PlayDataSet(id: id, name: name, API: API, keys: keys)
        _datasets[id] = newDataSet
        
    }

    func create (id: Int, name: String, keys: [String]) {
        
        var newDataSet = PlayDataSet(id: id, name: name, keys: keys)
        _datasets[id] = newDataSet
        
    }


    func getDataSet (id: Int) -> PlayDataSet? {
        
        return _datasets[id]
        
    }

}