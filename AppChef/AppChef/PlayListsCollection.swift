//
//  ListsCollection.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit

class PlayListsCollection {
    
    var _lists = [Int: PlayListViewController]()
    
    var mainViewController: UIViewController
    var appDelegate: AppDelegate
    
    init () {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        mainViewController = appDelegate.playViewController!.mainViewController!
    }
    
    func create (id: Int, viewController: UIViewController, source: Int, size: CGRect) -> PlayListViewController {
        
        var newList = PlayListViewController()
        newList.view.frame = size
        let dataSource = appDelegate.playViewController!.DataSets!.getDataSet(source)
        newList.setDataSet(dataSource!)
        
        _lists[id] = newList
        
        viewController.addChildViewController(newList)
        viewController.view.addSubview(newList.view)
        
        return newList
        
    }
    
    
    func getList (id: Int) -> PlayListViewController? {
        
        return _lists[id]
        
    }
    

}