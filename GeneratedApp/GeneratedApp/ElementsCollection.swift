//
//  ElementsCollection.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKIt

enum Place: Int {
    case Left
    case Right
}

class ElementsCollection {
    
    var _elements = [Int: [String: AnyObject]]()

    var _view: UIView?
    var _viewController: UIViewController?
    
    var _navbaritem: UINavigationItem?
    
    init () {
    }
 
    init (viewController: UIViewController) {
        _viewController = viewController
        _view = viewController.view
    }

    init (view: UIView) {
        _view = view
    }

    
    func addNavBar (id: Int, text: String) {
        if _view == nil {
            return
        }
        
        var bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: _view!.bounds.width, height: 64))
        _view!.addSubview(bar)
        _navbaritem = UINavigationItem(title: text)
        bar.pushNavigationItem(_navbaritem!, animated: false)

        _elements[id] = ["type": "UINavigationBar", "UINavigationBar": bar]
    }
    
    
    func addNavBarButton (id: Int, text: String, place: Place) {
        if _viewController == nil {
            return
        }
        
        var btn: UIBarButtonItem?
        
        if (place == .Right) {
            btn = UIBarButtonItem(title: text, style: UIBarButtonItemStyle.Plain, target: _viewController!, action: nil)
            _navbaritem!.rightBarButtonItem = btn
            
            
        } else {
            btn = UIBarButtonItem(title: text, style: UIBarButtonItemStyle.Plain, target: _viewController!, action: nil)
            _navbaritem!.leftBarButtonItem = btn
        }
        
        _elements[id] = ["type": "UIBarButtonItem", "UIBarButtonItem": btn!]
        
    }
    
    func addDynamicLabel(id: Int, text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        _elements[id] = ["type" : "UILabel", "source": text, "UILabel": label]
    }

    func addStaticLabel(id: Int, text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 80, width: 100, height: 23))
        label.text = text
        _view!.addSubview(label)
        _elements[id] = ["type" : "UILabel", "text": text, "UILabel": label]
    }

    func addDynamicButton(id: Int, text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        _elements[id] = ["source": text, "UILabel": label]
    }
    
    func addStaticButton(text: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        label.text = text
        _view!.addSubview(label)
    }
    
    
    func getElement (id: Int) -> [String: AnyObject]? {
        return _elements[id]
    }
    
    func getElements () -> [[String: AnyObject]] {
        
        var _elementsArray: [[String: AnyObject]] = []
        
        for key in _elements.keys {
            _elementsArray.append(_elements[key]!)
        }
        
        return _elementsArray
    }
    
}