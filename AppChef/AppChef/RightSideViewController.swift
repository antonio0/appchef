//
//  RightSideViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class RightSideViewController: UIViewController {

    
    var _delegate: MainEditViewController?
    
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
    var dataSetsViewController = DataSetsViewController()

    
    func setDelegate (delegate: MainEditViewController) {
        _delegate = delegate
        dataSetsViewController.setMainVC(delegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        newModelController.setDelegate(self)
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

    
    
    
    var dragging = false;
    var start: CGPoint? = nil;
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        recurseView(self.view);
        println("touchesbegan")
        if _delegate!.sideBarShowing == .Right {
            dragging = true;
            let touch: AnyObject? = touches.anyObject();
            start = touch!.locationInView(self.view)
        }
    }
    
    func recurseView(view: UIView) {
        for subview in view.subviews {
            self.recurseView(subview as UIView);
        }
        view.resignFirstResponder();
    }
    
    var path = UIBezierPath();
    var shapeLayer = CAShapeLayer();
    var wiggle = false
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        if dragging == false {
            return
        }
        
        println("Dragging: \(dragging)")
        let touch: AnyObject? = touches.anyObject();
        var end = touch!.locationInView(self.view);
        
        path.removeAllPoints();
        var dx = end.x - start!.x;
        var dy = end.y - start!.y;
        path.moveToPoint(start!)
        path.addLineToPoint(touch!.locationInView(self.view))
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.blackColor().CGColor;
        shapeLayer.lineWidth = 2;
        shapeLayer.fillColor = UIColor.clearColor().CGColor;
        self.view.layer.addSublayer(shapeLayer)
        //
        
        //        if (touch!.view != self.view.superview?.viewWithTag(55)) {
        //            println("it touching thing")
        //        } else {
        //            println("it is not touching")
        //        }
        
        if (CGRectContainsPoint(_delegate!.label.frame, touch!.locationInView(_delegate!.view))) {
            println("it touching thing")
            startWiggle()
        } else {
            if wiggle {
                stopWiggle()
            }
        }
        
    }
    
    
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        dragging = false;
        start = nil;
        stopWiggle()
        shapeLayer.path = nil;
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    func radians(r: Double) -> CGFloat {
        return (CGFloat)((r * M_PI) / 180.0);
    }
    
    
    func startWiggle() {
        var rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, radians(5.0));
        
        wiggle = true
        UIView.animateWithDuration(0.18, delay: 0.0, options: (UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse), animations: {
            self._delegate!.label.transform = rightWobble
            }, completion: nil);
        
    }
    
    func stopWiggle() {
        
        wiggle = false
        UIView.animateWithDuration(0.18, delay: 0.0, options: (UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveLinear), animations: {
            self._delegate!.label.transform =  CGAffineTransformIdentity
            }, completion: nil);
        
    }

    
    
}
