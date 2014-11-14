//
//  PagesCollection.swift
//  MyApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit

class PagesCollection {
    
    var _pages = [Int: PageViewController]()
    
    var mainViewController: UIViewController
    var appDelegate: AppDelegate
    
    init () {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        mainViewController = appDelegate.mainViewController!
    }
    
    func create (id: Int) {

        var newPage = PageViewController()
        newPage.setId(id)
        _pages[id] = newPage
        
    }

    

    func showPage (id: Int) {
        

        
    }
    
}