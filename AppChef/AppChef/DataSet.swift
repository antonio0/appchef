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
    var id: Int
    var keys : [String] = []
    var type: ModelType
    var apiUrl: String?
    var parseObjectName: String?
//    var id: Int
    var name: String
    
    init(name: String, type: ModelType, id: Int) {
        self.id = id
        self.name = name;
        self.type = type;
    }
    
    func toJSON() {
        
    }
    
    func toDictionary() -> [String: AnyObject]{
        var dictionary: [String: AnyObject] = [:]
        dictionary["id"] = id;
        dictionary["keys"] = self.keys
        dictionary["apiUrl"] = self.apiUrl
        dictionary["parseObjectName"] = self.parseObjectName
        
        return dictionary
    }
    
    
}