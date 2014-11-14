//
//  PageViewController.swift
//  MyApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    
//    var _itemsToAdd = [Int: [String: Int]]()

    var _id = -1
   
    var mainViewController: UIViewController?
    var appDelegate: AppDelegate?
    var Elements: ElementsCollection?

    // basically the initialiser
    func setId(id: Int) {
        self._id = id
        Elements = ElementsCollection(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        mainViewController = appDelegate!.mainViewController
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func test () {
        println("clicked")
    }
    
    func addAction(elementId: Int, navigateTo: Int) {
        let elementDict = Elements!.getElement(elementId)
        
        if elementDict == nil {
            return
        }
        
        let type = elementDict!["type"] as String
        
        var element: AnyObject? = elementDict![type]
        
        switch (type) {
            case "UIBarButtonItem":
                var castedelement = element as UIBarButtonItem
                castedelement.tag = navigateTo
                castedelement.action = "navigateToPage:"
//                castedelement.addTarget!(target: self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)

            default:
                1+1
        }
        
        
    }
    
    func navigateToPage(sender: UIBarButtonItem) {
        appDelegate!.Pages!.showPage(sender.tag)
    }
    
    func addList(id: Int, source: Int, size: CGRect) {
        
        var newList = appDelegate!.Lists!.create(id, viewController: self, source: source, size: size)
        
        let dataSource = appDelegate!.DataSets?.getDataSet(source)
        newList.setDataSet(dataSource!)
        
//        newList.view.center = self.view.center;
        
    }
    
    
    
//    func addAction(id: Int, addToDataSet: Int, itemsToAdd: [String: Int]) {
//        let elementDict = Elements!.getElement(id)
//        if elementDict == nil {
//            return
//        }
//        
//        let type = elementDict!["type"] as String
//        var element: AnyObject? = elementDict![type]
//        
//        switch (type) {
//            case "UIButton":
//                var btn = element as UIButton
//                btn.tag = addToDataSet
//                _itemsToAdd[id] = itemsToAdd
//                btn.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
//
//            default:
//                1+1
//     
//        }
//    }
    
    func buttonClicked (sender: UIButton) {
        let buttonClickedTag = sender.tag
        println("clicked")
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

