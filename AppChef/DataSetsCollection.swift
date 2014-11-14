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
    
    var datasets : [DataSet] = []
    
    override init() {
        
    }
    
    func create(name:String, type: ModelType, keys: [String]) {
        var newDataSet = DataSet(name: name, type: type)
        newDataSet.keys = keys
        self.datasets.append(newDataSet)
    }
    
    func toJSON() {
        
    }
    
}