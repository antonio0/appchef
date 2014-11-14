//
//  LeftSideBarViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class LeftSideBarViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
//
//    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
//        // Initialize variables.
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//    }

    var actions = ["Save","Sync","Play", "Submit to AppStore"];
    var blurredLayer : UIVisualEffectView?
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell?
        
        if(cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
        }
        
//        cell!.
        cell!.textLabel.text = actions[indexPath.row];
        return cell!;
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            
            var dictionary = [
                "pages": appDelegate.pagesCollection!.toDictionary(),
                "datasets": appDelegate.dataSetsCollection!.toDictionary()
            ]
            println(Helper.JSONStringify(dictionary, prettyPrinted: true))
//            println(appDelegate.pagesCollection!.toJSON())
        } else if indexPath.row == 2 {
            let playController = PlayViewController();
            playController.view.frame = self.view.frame;
            playController.view.backgroundColor = UIColor.redColor()
            
            self.presentViewController(playController, animated: true, completion: { () -> Void in
                
            })
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = self.view.frame
        self.blurredLayer = visualEffectView;
        self.tableView.separatorStyle = .None;
        self.view.insertSubview(self.blurredLayer!, atIndex: 0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
