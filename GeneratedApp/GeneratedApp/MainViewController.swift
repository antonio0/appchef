//
//  ViewController.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var appDelegate: AppDelegate?

    var Pages: PagesCollection?
    var DataSets: DataSetsCollection?
    var Lists: ListsCollection?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        Pages = appDelegate?.Pages
        DataSets = appDelegate?.DataSets
        Lists = appDelegate?.Lists
        
        play()

    }
    
    
    func play () {
        
        Pages!.create(0)
        Pages!.create(1)

        
        Pages!.getPage(1)!.Elements!.addNavBar(0, text: "Basket")
        Pages!.getPage(1)!.Elements!.addNavBarButton(1, text: "Back to Shop", place: .Left)
        Pages!.getPage(1)!.Elements!.addNavBarButton(2, text: "Checkout", place: .Right)
        
        Pages!.getPage(1)!.addAction(1, navigateTo: 0)
        
//        Pages!.getPage(1)!.Elements!.getElement(1).addAction()
        
        Pages!.getPage(1)!.Elements!.addStaticLabel(22, text: "sdfsdf")

        DataSets!.create(0, name: "items", API: "https://hcssdmkprq.localtunnel.me", keys: [ "sku", "name", "color", "detail", "price", "brand"] )
        DataSets!.create(1, name: "basket", keys: [ "aasd", "asdasd"] )
        
    
        Pages!.getPage(0)!.addList(0, source: 0)
        
        Lists!.getList(0)!.Elements.addDynamicLabel(234, text: "name")
        Lists!.getList(0)!.Elements.addDynamicLabel(324, text: "price")
        
        
        
        Pages!.showPage(1)

        
        
        
        //Pages!.getPage(0).addLabel(id, type)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

