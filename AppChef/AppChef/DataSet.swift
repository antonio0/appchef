//
//  DataSet.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit


class DataSet {
    var keys : [String] = []
    var type: ModelType
    var apiUrl: String?
    var parseObjectName: String?
//    var id: Int
    var name: String
    
    init(name: String, type: ModelType) {
        self.name = name;
        self.type = type;
    }
    
    func toJSON() {
        
    }
    
    
}