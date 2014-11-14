//
//  ElementsTouchController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit


class ElementsTouchController: NSObject {
    var mainView : UIView
    var activeModal: EditElement?
    
    init(mainView: UIView) {
        self.mainView = mainView
    }
    
    func drag(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(self.mainView)
        recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.mainView)
        
    }
    
    func longTouch(recognizer: UILongPressGestureRecognizer) {
        if(self.activeModal == nil) {
            self.createModal(recognizer)
        } else {
            self.removeActiveModal()
            self.createModal(recognizer)
        }
    }
    
    func removeActiveModal() {
        self.activeModal!.view.removeFromSuperview()
        self.activeModal == nil;
    }
    
//    func createModal(recognizer: UILongPressGestureRecognizer) {
//        let modal = EditElementViewController(nibName: "EditElementViewController", bundle: nil)
//        var paddingOverElement = 50;
//        
//        modal.view.frame.origin.x = 50
//        
//        if(Int(modal.view.frame.size.height) + paddingOverElement + Int(recognizer.view!.frame.origin.y) + Int(recognizer.view!.frame.height) > Int(UIScreen.mainScreen().bounds.height)) {
//            
//            var yBelowElement = Int(recognizer.view!.frame.origin.y) - Int(recognizer.view!.frame.height) - paddingOverElement;
//            modal.view.frame.origin.y = CGFloat(yBelowElement);
//            
//        } else {
//            var yAboveElement = Int(recognizer.view!.frame.origin.y) + Int(recognizer.view!.frame.height) + paddingOverElement;
//            modal.view.frame.origin.y = CGFloat(yAboveElement);
//        }
//        
//        self.activeModal = modal;
//        self.mainView.addSubview(modal.view)
//
//    }

    func createModal(recognizer: UILongPressGestureRecognizer) {
        let modal = EditElement(nibName: "EditElement", bundle: nil)
        var paddingOverElement = 50;
        
        modal.view.frame = CGRect(x: 0, y: mainView.bounds.height - 500, width: mainView.bounds.width, height: 500)
        
        
        
        mainView.addSubview(modal.view)
        mainView.bringSubviewToFront(modal.view)
        
        modal.view.frame.origin.y = mainView.bounds.height + 500
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            modal.view.frame.origin.y = self.mainView.bounds.height - 500
            
            }, completion: nil)

//        
//        
//        if(Int(modal.view.frame.size.height) + paddingOverElement + Int(recognizer.view!.frame.origin.y) + Int(recognizer.view!.frame.height) > Int(UIScreen.mainScreen().bounds.height)) {
//            
//            var yBelowElement = Int(recognizer.view!.frame.origin.y) - Int(recognizer.view!.frame.height) - paddingOverElement;
//            modal.view.frame.origin.y = CGFloat(yBelowElement);
//            
//        } else {
//            var yAboveElement = Int(recognizer.view!.frame.origin.y) + Int(recognizer.view!.frame.height) + paddingOverElement;
//            modal.view.frame.origin.y = CGFloat(yAboveElement);
//        }
//        
        self.activeModal = modal;
//        self.mainView.addSubview(modal.view)
        
    }
    

}