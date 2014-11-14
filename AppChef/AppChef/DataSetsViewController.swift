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
    
    func panGestureDetected(recognizer:UIPanGestureRecognizer) {
        println("pan")
        let translation = recognizer.translationInView(self.view)
        
        if dragging == false {
            
            var cell = getCell(recognizer.locationInView(self.view))
            if cell != nil {
                start = cell!.center
                
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

                endMoveLine(recognizer.locationInView(mainVC!.view))
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
        
            cell!.textLabel.text = self.appDelegate!.dataSetsCollection!.datasets[indexPath.row].name;
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
    }
    
    func endMoveLine(point: CGPoint) {
        dragging = false;
        start = nil;
        //stopWiggle()
        mainVC!.shapeLayer.path = nil;
    }
    
    


}