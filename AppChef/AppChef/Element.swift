//
//  Element.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class Element {
    var uiElement : UIView
    var type:  String
    
    init(uiElement: UIView, type: String) {
        self.uiElement = uiElement
        self.type      = type
    }
    
    func toJSON() -> NSString {
        return Helper.JSONStringify(self.toDictionary(), prettyPrinted: false)
    }
    
    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        
        dictionary["type"]  = "\(self.type)";
        dictionary["id"]    = 0
        dictionary["frame"] = [
            "x"      : "\(self.uiElement.frame.origin.x)",
            "y"      : "\(self.uiElement.frame.origin.y)",
            "width"  : "\(self.uiElement.frame.size.width)",
            "height" : "\(self.uiElement.frame.size.height)"
        ];
        
        if(self.type == "button") {
            let button = self.uiElement as UIButton;
            dictionary["text"]      = button.titleLabel!.text
            dictionary["textColor"] = button.titleLabel!.textColor
        } else if (self.type == "label") {
            
        } else if (self.type == "input") {
            
        } else if (self.type == "image") {
            
        }
        
        return dictionary;
    }
}