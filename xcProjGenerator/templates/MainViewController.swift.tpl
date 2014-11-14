//
//  ViewController.swift
//  {{ appname }}
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var appDelegate: AppDelegate?

    var Pages: PagesCollection?
    var DataSets: DataSetsCollection?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        Pages = appDelegate?.Pages
        DataSets = appDelegate?.DataSets

        play()

    }


    func play () {

        Pages!.create(0)
        Pages!.create(1)

        {{ jessiescode }}


        DataSets!.create(0, name: "items", API: "https://api.zalando.com/articles?pageSize=10", keys: [ "aasd", "asdasd"] )
        DataSets!.create(1, name: "basket", keys: [ "aasd", "asdasd"] )



        DataSets!.getDataSet(0)!.add(["one" : "the", "two": "quick", "three": "brown"])

        Pages!.getPage(0)!.addList(0, source: 0)

//        Lists!.getList(0).addElement()


        Pages!.showPage(0)




        //Pages!.getPage(0).addLabel(id, type)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
