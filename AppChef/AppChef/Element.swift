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
    
    init(uiElement: UIView) {
        self.uiElement = uiElement
    }
    
    func toJSON() -> NSString {
        return ""
    }
}