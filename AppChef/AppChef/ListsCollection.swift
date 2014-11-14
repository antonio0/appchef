//
//  ListsCollection.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit

class ListsCollection {
    
    var _lists = [Int: ListViewController]()
    
    var mainViewController: UIViewController
    var appDelegate: AppDelegate
    
    init () {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        mainViewController = appDelegate.mainViewController!
    }
    
    func create (id: Int, viewController: UIViewController, source: Int, size: CGRect) -> ListViewController {
        
        var newList = ListViewController()
        newList.view.frame = size
        let dataSource = appDelegate.DataSets!.getDataSet(source)
        newList.setDataSet(dataSource!)
        
        _lists[id] = newList
        
        viewController.addChildViewController(newList)
        viewController.view.addSubview(newList.view)
        
        return newList
        
    }
    
    
    func getList (id: Int) -> ListViewController? {
        
        return _lists[id]
        
    }
    

}