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
    var id : Int
    init() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.id = appDelegate.newID()
        
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
    
    
    
    
    func addElement(uiViewElementToBeAdded: UIView, type: String, point: CGPoint) -> Element{
        
        var newElement = self.createElement(uiViewElementToBeAdded, type: type)
        
        if let existingElement = self.getElement(point) {
            if(existingElement.type == "list") {
                existingElement.cellElements.append(newElement)
                
                
                self.view.addSubview(uiViewElementToBeAdded)
                
                return newElement;
            
            } else {
                 self.elements.append(newElement)
            }
        } else {
            self.elements.append(newElement)
        }
        
        newElement.indexInPage = self.elements.count - 1;
        self.view.addSubview(uiViewElementToBeAdded)
        return newElement
    }
    
    func moveToList(element: Element, list: Element) {
        
        self.elements.removeAtIndex(element.indexInPage!)
        
        element.uiElement.removeFromSuperview()

        list.uiElement.addSubview(element.uiElement)
        list.cellElements.append(element)
    }
   
    func createElement(uiViewElementToBeAdded: UIView, type: String) -> Element {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let element = Element(uiElement: uiViewElementToBeAdded, type: type, id: appDelegate.newID())
        
        return element
    }
    
    func getElementForDataSet  (point: CGPoint) -> Element? {
        for element in self.elements {
            
//            CGRect frame = [firstView convertRect:buttons.frame fromView:secondView]
            
            for cellElement in element.cellElements {
                let frame = cellElement.uiElement.convertRect(cellElement.uiElement.frame, fromView: self.view)
                if CGRectContainsPoint(frame, point) {
                    return cellElement
                }
            }
            
            if(element.type == "list") {
                continue
            }
            
            if CGRectContainsPoint(element.uiElement.frame, point) {
                return element
            }
            
        }
        return nil
    }

    
    func getElement (point: CGPoint) -> Element? {
        for element in self.elements {
            
            if CGRectContainsPoint(element.uiElement.frame, point) {
                return element
            }
            
            for cellElement in element.cellElements {
                if CGRectContainsPoint(cellElement.uiElement.frame, point) {
                    return cellElement
                }
            }
            
        }
        return nil
    }
    
    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = self.id;
        
        var elementsArray = [AnyObject]()
        
        for element in self.elements {
            elementsArray.append(element.toDictionary())
        }
        
        dictionary["elements"] = elementsArray;
        
        return dictionary
        
    }
}
