//
//  DataSet.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

enum DataSetType {
    case Parse
    case REST
}

class DataSet {
    var keys : [String] = []
    var type: DataSetType
    var apiUrl: String?
    var parseObjectName: String?
//    var id: Int
    var name: String
    
    init(name: String, type: DataSetType) {
        self.name = name;
        self.type = type;
    }
    
    func toJSON() {
        
    }
    
    
}