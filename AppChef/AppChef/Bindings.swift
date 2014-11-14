//
//  Bindings.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class Bindings {
    
    
    var _sourceBindings: [Int: [String: Int]] = [:]
    
    init () {
        
    }
    
    func addSourceBinding (dataSet: Int, element: Int, key: String) {
        if  _sourceBindings[dataSet] == nil {
            _sourceBindings[dataSet] = [:]
        }
        
        _sourceBindings[dataSet]![key] = element
        
    }
    
}