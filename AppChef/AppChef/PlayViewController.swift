//
//  PlayViewController.swift
//  AppChef
//
//  Created by Hackathon on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit
import Parse

class PlayViewController: UIViewController {
<<<<<<< HEAD
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
=======

    var window: UIWindow?
    
    var Pages: PlayPagesCollection?
    var DataSets: PlayDataSetsCollection?
    var Lists: PlayListsCollection?
    
    var mainViewController: UIViewController?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let json = appDelegate.pagesCollection!.toJSON()
        self.play(json)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func play (json: String) {
        Parse.setApplicationId("T3H7seI5xKXazNt45ftBQ6hakcL5tu2de8BJPHXv", clientKey: "K0EtNnUbTqZN3RMgSlQODJ2gzy1ndMwLYElgV4vZ");
        mainViewController = self.window!.rootViewController
        Pages = PlayPagesCollection()
        DataSets = PlayDataSetsCollection()
        Lists = PlayListsCollection()
        var jsondecoder = PlayJsonDecoder(jsonTemp: json.dataUsingEncoding(NSUTF8StringEncoding)!, outputFile: "")
//        var jsondecoder = PlayJsonDecoder(json.stringValue.dataUsingEncoding(NSUTF8StringEncoding)!, outputFile: "" )
        jsondecoder.parse()
        
        
    }


>>>>>>> b8f1676e15a1f2876d82af4e80759dfa60169f52
}
