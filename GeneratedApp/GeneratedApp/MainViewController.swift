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

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    func play () {
        
        DataSets!.create(100, name: "items", API:"https://ovairxajzm.localtunnel.me", keys: ["sku" ,"name" ,"color" ,"detail" ,"price" ,"brand"])
        DataSets!.create(101, name: "basket", keys: ["name" ,"price"])
        Pages!.create(0)
        Pages!.getPage(0)!.Elements!.addNavBar(10, text: "Shopping List")
        Pages!.getPage(0)!.Elements!.addNavBarButton(20, text:"Basket", place: .Right )
        Pages!.getPage(0)!.addAction(20, navigateTo:1)
        Pages!.getPage(0)!.addList(2, source: 100, size: CGRect(x:0, y:65, width:self.view.bounds.width, height:self.view.bounds.height))
        Lists!.getList(2)!.Elements.addDynamicLabel(3, key:"name", size:CGRect(x:120, y:10, width:400, height:23) )
        Lists!.getList(2)!.Elements.addDynamicLabel(4, key:"price", size:CGRect(x:120, y:35, width:100, height:23) )
        Lists!.getList(2)!.Elements.addDynamicImage(5, key:"detail", size:CGRect(x:10, y:10, width:100, height:100) )
        Lists!.getList(2)!.Elements.addStaticButton(6, text:"Add to Basket", size: CGRect(x:120, y:65, width:170, height:30) )
        Lists!.getList(2)!.addAction(6, addToDataSet: 101, itemsToAdd: [ "name":3, "price":4])
        Pages!.create(1)
        Pages!.getPage(1)!.Elements!.addNavBar(12, text: "Basket")
        Pages!.getPage(1)!.Elements!.addNavBarButton(13, text:"Back to shop", place: .Left )
        Pages!.getPage(1)!.addAction(13, navigateTo:0)
        Pages!.getPage(1)!.Elements!.addNavBarButton(14, text:"Checkout", place: .Right )
        Pages!.getPage(1)!.addList(15, source: 101, size: CGRect(x:0, y:65, width:self.view.bounds.width, height:self.view.bounds.height))
        Lists!.getList(15)!.Elements.addDynamicLabel(16, key:"name", size:CGRect(x:120, y:10, width:400, height:23) )
        Lists!.getList(15)!.Elements.addDynamicLabel(17, key:"price", size:CGRect(x:120, y:40, width:400, height:23) )
        
        
        
        
        
        
        /*
        Pages!.create(0)
        Pages!.create(1)
        
        DataSets!.create(0, name: "items", API: "https://hcssdmkprq.localtunnel.me", keys: [ "sku", "name", "color", "detail", "price", "brand"] )
        DataSets!.create(1, name: "basket", keys: [ "name", "price"] )
        
        
        Pages!.getPage(0)!.Elements!.addNavBar(10, text: "Shopping List")
        Pages!.getPage(0)!.Elements!.addNavBarButton(20, text: "Basket", place: .Right)
        Pages!.getPage(0)!.addAction(20, navigateTo: 1)
        
        Pages!.getPage(1)!.Elements!.addNavBar(0, text: "Basket")
        Pages!.getPage(1)!.Elements!.addNavBarButton(1, text: "Back to Shop", place: .Left)
        Pages!.getPage(1)!.Elements!.addNavBarButton(2, text: "Checkout", place: .Right)
        
        Pages!.getPage(1)!.addAction(1, navigateTo: 0)
        
        //        Pages!.getPage(1)!.Elements!.getElement(1).addAction()
        
        Pages!.getPage(1)!.Elements!.addStaticLabel(22, text: "sdfsdf", size: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        
        
        Pages!.getPage(0)!.addList(0, source: 0, size: CGRect(x: 0, y: 65, width: self.view.bounds.width, height: self.view.bounds.height - 65))
        
        Lists!.getList(0)!.Elements.addDynamicLabel(234, key: "name", size: CGRect(x: 120, y: 10, width: 400, height: 23))
        Lists!.getList(0)!.Elements.addDynamicLabel(325, key: "price", size: CGRect(x: 120, y: 35, width: 100, height: 23))
        Lists!.getList(0)!.Elements.addDynamicImage(326, key: "detail", size: CGRect(x: 10, y: 10, width: 100, height: 100))
        Lists!.getList(0)!.Elements.addStaticButton(327, text: "Add to Basket", size: CGRect(x: 120, y: 65, width: 170, height: 30))
        
        Lists!.getList(0)!.addAction(327, addToDataSet: 1, itemsToAdd: ["name": 234, "price": 325])
        */
        
        Pages!.showPage(0)
        
        //      Pages!.getPage(1)!.addList(11, source: 1, size: CGRect(x: 0, y: 65, width: self.view.bounds.width, height: self.view.bounds.height - 65))
        //      Lists!.getList(11)!.Elements.addDynamicLabel(500, key: "name", size: CGRect(x: 120, y: 10, width: 400, height: 23))
        //     Lists!.getList(11)!.Elements.addDynamicLabel(501, key: "price", size: CGRect(x: 120, y: 40, width: 400, height: 23))
        
        
        
        //Pages!.getPage(0).addLabel(id, type)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

