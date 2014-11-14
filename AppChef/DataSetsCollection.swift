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
    
    func createDataSet(name:String, type: DataSetType) -> DataSet {
        let newDataSet = DataSet(name: name, type: type)
        self.datasets.append(newDataSet)
        
        return newDataSet
    }
    
    func toJSON() {
        
    }
    
}