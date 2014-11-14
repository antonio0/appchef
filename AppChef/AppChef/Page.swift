//
//  Page.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class Page {
    
    var elements : [Element] = []
    var screenshot : UIImage?
    var view : UIView
    
    init() {
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        self.view.backgroundColor = UIColor.whiteColor()
        self.updateScreenshot()
    }
    
    func updateScreenshot() {
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 1)
        self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: true)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.screenshot = screenshot;
    }
    
    
    func addElement(uiViewElementToBeAdded: UIView, type: String) {
        let element = Element(uiElement: uiViewElementToBeAdded, type: type)
        self.elememnts.append(element)
        self.view.addSubview(uiViewElementToBeAdded)
    }
    
    func getElement (point: CGPoint) -> UIView? {
        for element in self.elements {
            if CGRectContainsPoint(element.uiElement.frame, point) {
                return element.uiElement
            }
        }
        return nil
    }
    
    func toJSON() -> NSString {
        return "hello"
    }
}
