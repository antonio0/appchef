//
//  PagesCollection.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class DataSetsCollection : NSObject {
    
    var datasets = [Int: DataSet]()
    
    override init() {
        
    }
    
    func create(name:String, type: ModelType, keys: [String]) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        
        var id =  appDelegate.newID()
        var newDataSet = DataSet(name: name, type: type, id: id)
        newDataSet.keys = keys
        self.datasets[id] = newDataSet
    }
    
    func dataSetArray() -> [DataSet] {
        return [DataSet](datasets.values)
    }
    
    func getDataSet(id: Int) -> DataSet? {
        return datasets[id]
    }
    
    func toJSON() {
        
    }
    
}