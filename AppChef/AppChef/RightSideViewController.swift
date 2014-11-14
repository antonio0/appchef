//
//  RightSideViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class RightSideViewController: UIViewController {

    
    var _delegate: UIViewController?
    
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
    
      
    var addDataSet: UIButton?
    
    var newModelController = NewModelViewController(nibName: "NewModelViewController", bundle: nil)
    
    
    func setDelegate (delegate: UIViewController) {
        _delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dataSetsViewController = DataSetsViewController()
        
        
        
        dataSetsViewController.tableView.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.addChildViewController(dataSetsViewController)
        self.view.addSubview(dataSetsViewController.tableView)

        
        addDataSet = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        addDataSet!.backgroundColor = UIColor.redColor()
        addDataSet!.setTitle("New DataSet +", forState: .Normal)
        addDataSet!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addDataSet!.addTarget(self, action: "newModel", forControlEvents: .TouchUpInside)
        self.view.addSubview(addDataSet!)

        
        
        
        //        var PagesViewController    = SideTableViewController()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func newModel () {
        println("new model")
        newModelController.view.frame = CGRect(x: 0, y: self.view.superview!.bounds.height - 500, width: self.view.superview!.bounds.width, height: 500)
//        newModelController.view.center = self.view.superview!.center
        self.view.superview!.addSubview(newModelController.view)
        self.view.superview!.bringSubviewToFront(newModelController.view)
        newModelController.view.frame.origin.y = self.view.superview!.bounds.height + 500
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.newModelController.view.frame.origin.y = self.view.superview!.bounds.height - 500
        }, completion: nil)

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
