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
    var draggedElement   : UIView?
    var pagesCollection  : PagesCollection?
    var delegate:          MainEditViewController?
    
    let tint = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1.0)

    
    @IBOutlet weak var inputFieldIcon: UIImageView!
    @IBOutlet weak var buttonIcon: UIImageView!
    @IBOutlet weak var pictureIcon: UIImageView!
    @IBOutlet weak var Label: UIImageView!
    
    
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
        self.initPicture()
        self.initLabel()
        self.initInputField()
        // Do any additional setup after loading the view.
    }
    
    func initInputField() {
        let inputFactoryRec = UIPanGestureRecognizer(target: self, action: "spanInput:")
        self.inputFieldIcon.addGestureRecognizer(inputFactoryRec)
        self.inputFieldIcon.userInteractionEnabled = true;
        
    }
    
    
    func initButton() {
        let buttonFactoryRecognizer = UIPanGestureRecognizer(target: self, action: "spanButton:")
        
        self.buttonIcon.addGestureRecognizer(buttonFactoryRecognizer)
        self.buttonIcon.userInteractionEnabled = true;
        
    }
    
    func initPicture() {
        let pictueFactoryRecognizer = UIPanGestureRecognizer(target: self, action: "spanPicture:")
        
        self.pictureIcon.addGestureRecognizer(pictueFactoryRecognizer)
        self.pictureIcon.userInteractionEnabled = true;
    }
    
    func initLabel() {
        let labelFactoryRecognizer =  UIPanGestureRecognizer(target: self, action: "spanLabel:")
        
        self.Label.addGestureRecognizer(labelFactoryRecognizer)
        self.Label.userInteractionEnabled = true;

    }

    func spanInput(recognizer: UIPanGestureRecognizer) {
        let activePage = self.pagesCollection?.activePage!;
        
        if (!self.dragging) {
            
            let input    = UILabel(frame: recognizer.view!.frame);
            input.frame.size = CGSize(width: 200, height: 50)
            input.text = "Text Input..";
            input.textColor = UIColor.grayColor()
            input.layer.cornerRadius = 20;
            
            let tint2 = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 0.2)

            input.backgroundColor = tint2;
            
            input.userInteractionEnabled = true;
//            input.= false;
            
            let dragRecognizer = UIPanGestureRecognizer(target: self.delegate!.touchController!, action: "drag:")
            input.addGestureRecognizer(dragRecognizer)
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self.delegate!.touchController!, action: "longTouch:")
            
            input.addGestureRecognizer(longPressRecognizer)
            
            activePage!.addElement(input, type: "input")
            
            self.dragging = true;
            self.draggedElement = input
            
            self.delegate!.hideAddElements()
            
        } else if(recognizer.state != UIGestureRecognizerState.Ended) {
            self.translate(recognizer)
            
        } else if(recognizer.state == UIGestureRecognizerState.Ended) {
            self.clean();
        }
    }

    
    func spanLabel(recognizer: UIPanGestureRecognizer) {
        let activePage = self.pagesCollection?.activePage!;
        
        if (!self.dragging) {
            
            let newLabel    = UILabel(frame: recognizer.view!.frame);
            newLabel.text = "Text Label";
            newLabel.textColor = UIColor.grayColor()
            
            let dragRecognizer = UIPanGestureRecognizer(target: self.delegate!.touchController!, action: "drag:")
            newLabel.addGestureRecognizer(dragRecognizer)
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self.delegate!.touchController!, action: "longTouch:")
            
            newLabel.addGestureRecognizer(longPressRecognizer)
            
            activePage!.addElement(newLabel, type: "label")
            
            self.dragging = true;
            self.draggedElement = newLabel
            
            self.delegate!.hideAddElements()
            
        } else if(recognizer.state != UIGestureRecognizerState.Ended) {
            self.translate(recognizer)
            
        } else if(recognizer.state == UIGestureRecognizerState.Ended) {
            self.clean();
        }
    }
    
    func spanPicture(recognizer: UIPanGestureRecognizer) {
        let activePage = self.pagesCollection?.activePage!;
        
        if (!self.dragging) {
            
            let picturePlaceHolder    = UIView(frame: recognizer.view!.frame);
            
            picturePlaceHolder.backgroundColor = UIColor.grayColor()
            
            let dragRecognizer = UIPanGestureRecognizer(target: self.delegate!.touchController!, action: "drag:")
            picturePlaceHolder.addGestureRecognizer(dragRecognizer)
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self.delegate!.touchController!, action: "longTouch:")
            
            picturePlaceHolder.addGestureRecognizer(longPressRecognizer)
            
            activePage!.addElement(picturePlaceHolder, type: "image")
            
            self.dragging = true;
            self.draggedElement = picturePlaceHolder
            
            self.delegate!.hideAddElements()
            
        } else if(recognizer.state != UIGestureRecognizerState.Ended) {
            self.translate(recognizer)
            
        } else if(recognizer.state == UIGestureRecognizerState.Ended) {
            self.clean();
        }
    }
    
    func translate(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        self.draggedElement!.center = CGPoint(x:recognizer.view!.center.x + translation.x,
            y:recognizer.view!.center.y + translation.y)
    }
    
    func clean() {
        self.draggedElement = nil
        self.dragging = false
        
        self.delegate!.removeAddElements()

    }
   
    func spanButton(recognizer: UIPanGestureRecognizer) {
        
        let activePage = self.pagesCollection?.activePage!;

        if (!self.dragging) {
            
            let newButton    = UIButton(frame: recognizer.view!.frame);
            newButton.frame.size = CGSize(width: 100, height: 50)
            
            //            newButton.backgroundColor = UIColor.redColor()
            
            newButton.setTitleColor(tint, forState: .Normal)
            newButton.setTitle("Button" ,forState: .Normal)
            newButton.layer.cornerRadius  = 10
            
            let dragRecognizer = UIPanGestureRecognizer(target: self.delegate!.touchController!, action: "drag:")
            newButton.addGestureRecognizer(dragRecognizer)
            
            let longPressRecognizer = UILongPressGestureRecognizer(target: self.delegate!.touchController!, action: "longTouch:")
            
            newButton.addGestureRecognizer(longPressRecognizer)
            
            activePage!.addElement(newButton, type: "button")

            self.dragging = true;
            self.draggedElement = newButton
            
            self.delegate!.hideAddElements()
            
        } else if(recognizer.state != UIGestureRecognizerState.Ended) {
            self.translate(recognizer)
        } else if(recognizer.state == UIGestureRecognizerState.Ended) {
            self.clean();

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
