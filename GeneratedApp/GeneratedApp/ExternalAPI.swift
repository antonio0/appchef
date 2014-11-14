//
//  ExternalAPI.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import Alamofire

class ExternalAPI {
    
    var _callback: (([[String: String]]) -> Void)?

    var _URI: String
    
    init (URI: String) {
        _URI = URI
    }
    
    func getData(callback: ([[String: String]]) -> Void) {
        Alamofire.request(.GET, _URI)
            .responseJSON { (_, _, JSONobj, _) in
                let json = JSON(JSONobj!)
                var result: [[String: String]] = []
                
                var count = 0;
                
                for (index: String, subJson: JSON) in json {
                    var row: [String: String] = [:]
                    for (key: String, subSubJson: JSON) in subJson {
                        
                        let datum: String = "\(json[count][key])"
                        row[key] = datum
                    }
                    result.append(row)
                    count = count+1
                }
                
                callback(result)
                
                
        }
        
    }
    
}