//
//  ElementsCollection.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKIt

class ElementsCollection {
    
    var _elements: [[String: AnyObject]] = []
    
    var _view: UIView?
    
    init () {
    }
 
    init (view: UIView) {
        _view = view
    }

    func addDynamicLabel(text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        if _view == nil {
            _elements.append(["source": text, "UILabel": label])
        } else {
            label.text = "asdasd"
            _view!.addSubview(label)
        }
       // _elements.append(["UILabel": label])
    }

    func addStaticLabel(text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        label.text = text
        _view!.addSubview(label)
    }
    
//    func addLabel(source: String, model) {
//        
//    }
    
    
    func getElements () -> [[String: AnyObject]] {
        return _elements
    }
    
}