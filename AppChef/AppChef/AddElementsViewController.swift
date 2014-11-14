 //
//  AddElementsViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class AddElementsViewController: UIViewController {

    var blurredLayer: UIVisualEffectView?
    var dragging       = false
    var draggedElement   : UIButton?
    var pagesCollection  : PagesCollection?
    var delegate:          MainEditViewController?
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        // Initialize variables.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initBluredLayer() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = self.view.frame
        self.blurredLayer = visualEffectView;
        self.view.insertSubview(self.blurredLayer!, atIndex: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBluredLayer()
        self.initButton()
        // Do any additional setup after loading the view.
    }
    
    
    func initButton() {
        let button = UIButton(frame: CGRect(x: 10, y: 150 , width: 100, height: 50));
        button.setTitle("Hello", forState: .Normal)
        button.backgroundColor = UIColor.blackColor()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
//        self.view.insetSubi(button)
        self.view.insertSubview(button, atIndex: 99)
        let buttonFactoryRecognizer = UIPanGestureRecognizer(target: self, action: "spanButton:")
        
        button.addGestureRecognizer(buttonFactoryRecognizer)
        button.layer.cornerRadius = 5
        
        
    }
    
    
    func spanButton(recognizer: UIPanGestureRecognizer) {
        
        let activePage = self.pagesCollection?.activePage!;

        if (!self.dragging) {
            
            let newButton    = UIButton(frame: recognizer.view!.frame);
            
            newButton.backgroundColor = UIColor.redColor()
            newButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            newButton.setTitle("Button" ,forState: .Normal)
            
            let dragRecognizer = UIPanGestureRecognizer(target: self.delegate!.touchController!, action: "drag:")
            newButton.addGestureRecognizer(dragRecognizer)
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self.delegate!.touchController!, action: "longTouch:")
            
            newButton.addGestureRecognizer(longPressRecognizer)
            
            activePage!.addElement(newButton)

            self.dragging = true;
            self.draggedElement = newButton
            
            self.delegate!.hideAddElements()
            
        } else if(recognizer.state != UIGestureRecognizerState.Ended) {
            
            let translation = recognizer.translationInView(self.view)
            self.draggedElement!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
                y:recognizer.view!.center.y + translation.y)
            
        } else if(recognizer.state == UIGestureRecognizerState.Ended) {
            self.draggedElement = nil
            self.dragging = false
            
            self.delegate!.removeAddElements()
        }
        
        
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
