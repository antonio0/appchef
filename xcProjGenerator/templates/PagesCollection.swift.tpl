//
//  PagesCollection.swift
//  {{ appname }}
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
        mainViewController.view.addSubview(newPage.view)

    }


    func getPage (id: Int) -> PageViewController? {

        return _pages[id]

    }

    func showPage (id: Int) {

        let page = getPage(id)

        if page != nil {

            mainViewController.view.bringSubviewToFront(page!.view)

        }

    }

}
