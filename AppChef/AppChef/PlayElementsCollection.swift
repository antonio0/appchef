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

class PlayElementsCollection {
    
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
    
    func addDynamicLabel(id: Int, key: String, size: CGRect) {
        var label = UILabel(frame: size)
        _elements[id] = ["type" : "UILabel", "source": key, "UILabel": label]
    }

    func addDynamicImage(id: Int, key: String, size: CGRect) {
        var img = UIImageView(frame: size)
        _elements[id] = ["type" : "UIImageView", "source": key, "UIImageView": img]
    }
    
    func addStaticLabel(id: Int, text: String, size: CGRect) {
        var label = UILabel(frame: size)
        label.text = text
        label.tag = id
        _view!.addSubview(label)
        _elements[id] = ["type" : "UILabel", "text": text, "UILabel": label]
    }

    func addStaticImage(id: Int, url: String, size: CGRect) {
        
        var img = UIImageView(frame: size)
//        
        PlayImage.download(NSURL(string: url)!, {image,
            error in
            img.image = image
        })
        
        _view!.addSubview(img)
        _elements[id] = ["type" : "UIImageView", "url": url, "UIImageView": img]
    }
    
    func addDynamicButton(id: Int, key: String) {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 23))
        _elements[id] = ["source": key, "UILabel": label]
    }
    
    
    func addStaticButton(id: Int, text: String, size: CGRect) {
        var button = UIButton(frame: size)
        button.setTitle(text, forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

        if _view != nil {
            println("ADDING")
            _view!.addSubview(button)
        }
        _elements[id] = ["type" : "UIButton", "text": text, "UIButton": button]
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