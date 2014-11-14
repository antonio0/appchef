//
//  PagesManagerViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class PagesManagerViewController: UIViewController {
    
    var blurredLayer: UIVisualEffectView?
    var pagesCollection: PagesCollection
    var pagesFrame: UIView?
    var delegate: MainEditViewController?
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        // Initialize variables.
        
        let appDelegate       = UIApplication.sharedApplication().delegate as AppDelegate
        self.pagesCollection = appDelegate.pagesCollection!;
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        let appDelegate       = UIApplication.sharedApplication().delegate as AppDelegate
        self.pagesCollection = appDelegate.pagesCollection!;
        
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
        self.createPagesList()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePagesList() {
        if(self.pagesFrame != nil) {
            pagesFrame!.removeFromSuperview()
            self.createPagesList()
        }
    }
    
    func createPagesList() {
        
        var frameWidth  = 0
        var frameHeight = 0
        
        
        var screenHeight =  UIScreen.mainScreen().bounds.height
        var screenWidth  =  UIScreen.mainScreen().bounds.width
        
        var width   = Int(screenWidth  / 2.2)
        var height  = Int(screenHeight / 2.2)
        
        println(width)
        
        var rightPadding = 25
        
        frameWidth = (self.pagesCollection.pages.count + 1) * (width + rightPadding)

        
        let pagesFrame = UIView(frame: CGRect(x: 50, y: 50, width: frameWidth, height: height))
        pagesFrame.center.y = screenHeight / 2
        self.pagesFrame = pagesFrame
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: "dragFrame:")
        self.pagesFrame?.addGestureRecognizer(dragGesture)
        var currentX = 0;
        var index    = 0;
        
        for page in self.pagesCollection.pages {
            let pageView = UIImageView(image: page.screenshot)
            pageView.frame = CGRect(x: currentX, y: 0, width: width, height: height);
            pageView.layer.cornerRadius = 10
            pageView.tag = index;
            pageView.userInteractionEnabled = true;
            
            let tapGesture = UITapGestureRecognizer(target: self, action: "switchToPage:")
            tapGesture.numberOfTapsRequired = 1
            pageView.addGestureRecognizer(tapGesture)
            
            pagesFrame.addSubview(pageView);
            currentX = currentX + width + rightPadding
            index++
            
            println(currentX)
        }
        
        self.createNewPageButton(currentX,width: width,height: height)
        self.view.addSubview(pagesFrame)
    }
    
    func createNewPageButton(currentX: Int, width: Int, height: Int) {
        let newPageButton = UIButton(frame: CGRect(x: currentX, y: 0, width: width, height: height))
        newPageButton.backgroundColor = UIColor.greenColor()
        newPageButton.layer.cornerRadius = 10
        newPageButton.addTarget(self, action: "addNewPage", forControlEvents: UIControlEvents.TouchUpInside)
        self.pagesFrame?.addSubview(newPageButton)
        
    }
    
    func dragFrame(recognizer: UIPanGestureRecognizer) {
        
        var screenWidth = UIScreen.mainScreen().bounds.width;
        
        let translation = recognizer.translationInView(self.pagesFrame!)
        let translatedX = recognizer.view!.frame.origin.x + (translation.x / 5);
        if(translatedX < 50 && (translatedX + self.pagesFrame!.frame.width) > screenWidth - 50 ) {
            recognizer.view!.frame.origin.x = translatedX
            
        }
    }
    
    func switchToPage(gesture: UIGestureRecognizer) {
        let page = self.pagesCollection.pages[gesture.view!.tag];
        self.delegate!.switchToPage(page);
        self.delegate!.hideUIViewWithAnimationAndRemove(self.view)
    }
    
    func addNewPage() {
        let newPage = self.pagesCollection.addPage()
        self.delegate!.hideUIViewWithAnimationAndRemove(self.view)
        self.delegate?.switchToPage(newPage)
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