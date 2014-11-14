//
//  SideTableViewController.swift
//  AppChef
//
//  Created by Mark on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class DataSetsViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    var dataSetsCollection : DataSetsCollection?
    var pagesCollection : PagesCollection?
    var appDelegate: AppDelegate?
//    var path = UIBezierPath();
//    var shapeLayer = CAShapeLayer();
    var wiggle = false
    
    var mainVC: MainEditViewController?
    
//
//    
   var panGesture: UIPanGestureRecognizer?
//    BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//    }
//    
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
    
    var addDataSet: UIButton?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        dataSetsCollection = appDelegate!.dataSetsCollection
        self.pagesCollection = appDelegate!.pagesCollection;
        
        panGesture = UIPanGestureRecognizer(target: self, action: "panGestureDetected:")
        
        panGesture!.maximumNumberOfTouches = 1;
        panGesture!.minimumNumberOfTouches = 1;
        panGesture!.delegate = self;
        self.tableView.addGestureRecognizer(panGesture!);
        
        // Do any additional setup after loading the view.
    }
    
    func setMainVC(vc: MainEditViewController) {
        self.mainVC = vc
    }
    
    var dragging = false
    var start: CGPoint?

    
    
    func getCell(point: CGPoint) -> UITableViewCell? {
        
        for cell in self.tableView.visibleCells() as [UITableViewCell] {
            if (CGRectContainsPoint(cell.frame, point)) {
                return cell
            }
        }
        return nil
    }
    
    
    var startDSId: Int?
    
    func panGestureDetected(recognizer:UIPanGestureRecognizer) {
        println("pan")
        let translation = recognizer.translationInView(self.view)
        
        if dragging == false {
            
            var cell = getCell(recognizer.locationInView(self.view))
            
            if cell != nil {
                start = cell!.center
                startDSId = cell!.tag
                start = CGPoint(x: start!.x + (mainVC!.view.bounds.width - 150), y: start!.y + 60 )
                dragging = true
            }
            
//            if (CGRectContainsPoint(label.frame, start) {
//                println("it touching thing")
//                startWiggle()
//            } else {
//                if wiggle {
//                    stopWiggle()
//                }
//            }
            
            //start = recognizer.locationInView(mainVC!.view)
            println("set start to \(start)")
        } else {
            
            if(recognizer.state == .Ended) {
                dragging = false
                endMoveLine(recognizer.locationInView(mainVC!.view), dataSet: appDelegate!.dataSetsCollection!.datasets[startDSId!]!)

            } else {
                moveLine(recognizer.locationInView(mainVC!.view))
            }
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell?
        
        if(cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellId)
            let dataSet: DataSet = self.appDelegate!.dataSetsCollection!.dataSetArray()[indexPath.row];
            cell!.tag = dataSet.id
            cell!.textLabel.text = dataSet.name;
        }
        
        cell!.selectionStyle = .None

            return cell!;
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSetsCollection!.datasets.count
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("touchesbegan")
    
    }
    
    func moveLine(to: CGPoint) {
        
        println("to: \(to), start: \(start)")
        mainVC!.path.removeAllPoints();
        var dx = to.x - start!.x;
        var dy = to.y - start!.y;
        mainVC!.path.moveToPoint(start!)
        mainVC!.path.addLineToPoint(to)
        mainVC!.shapeLayer.path = mainVC!.path.CGPath
        mainVC!.shapeLayer.strokeColor = UIColor.blackColor().CGColor;
        mainVC!.shapeLayer.lineWidth = 2;
        mainVC!.shapeLayer.fillColor = UIColor.clearColor().CGColor;
        mainVC!.view.layer.addSublayer(mainVC!.shapeLayer)
        
        if let foundElement = self.pagesCollection!.activePage?.getElement(to) {
             startWiggle(foundElement.uiElement)
             self.wigglingElement = foundElement.uiElement
        } else {
            if wiggle {
                stopWiggle()
            }
        }
        
        
        
    }
    
    var wigglingElement: UIView?
    
    func radians(r: Double) -> CGFloat {
        return (CGFloat)((r * M_PI) / 180.0);
    }
    
    
    func startWiggle(elementToWiggle: UIView) {
        var rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, radians(5.0));
        
        wiggle = true
        UIView.animateWithDuration(0.18, delay: 0.0, options: (UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.Autoreverse), animations: {
            elementToWiggle.transform = rightWobble
            }, completion: nil);
        
    }
    
    func stopWiggle() {
        
        wiggle = false
        UIView.animateWithDuration(0.18, delay: 0.0, options: (UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveLinear), animations: {
            self.wigglingElement!.transform =  CGAffineTransformIdentity
            }, completion: nil);
        
    }

    
    
    func endMoveLine(point: CGPoint, dataSet: DataSet) {
        dragging = false;
        start = nil;
        if wiggle {
            stopWiggle()
        }
        mainVC!.shapeLayer.path = nil;
        
    
        if let foundElement = self.pagesCollection!.activePage?.getElement(point) {
            bindElementToModel(foundElement, dataSet:dataSet)
        }
    }
    
    func bindElementToModel(element: Element, dataSet: DataSet) {
    
        bindElementModelController.currDataSource = dataSet.id
        bindElementModelController.currElement = element.id
        
        bindElementModelController.view.frame = CGRect(x: 0, y: mainVC!.view.bounds.height - 500, width: mainVC!.view.bounds.width, height: 500)
        //        newModelController.view.center = self.view.superview!.center
       
        self.view.superview!.superview!.addSubview(bindElementModelController.view)
        self.view.superview!.superview!.bringSubviewToFront(bindElementModelController.view)

        bindElementModelController.view.frame.origin.y = mainVC!.view.bounds.height + 500

        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.bindElementModelController.view.frame.origin.y = self.view.superview!.superview!.bounds.height - 500

            }, completion: nil)
    }

    var bindElementModelController = BindElementModelController(nibName: "BindElementModelController", bundle: nil)

}