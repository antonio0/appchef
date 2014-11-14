
//  MainEditViewController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import UIKit

class MainEditViewController: UIViewController {
    
    var pagesManager : PagesManagerViewController?
    var addElements  : AddElementsViewController?
    var leftSideBar  : LeftSideBarViewController?
    var rightSideBar : RightSideViewController?
    var touchController : ElementsTouchController?
    var pagesCollection : PagesCollection?
    var dataSetsCollection: DataSetsCollection?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate         = UIApplication.sharedApplication().delegate as AppDelegate
        self.pagesCollection    = appDelegate.pagesCollection!;
        self.dataSetsCollection = appDelegate.dataSetsCollection!;
        
        self.initElementsTouchController()
        
        
        self.initMenus()
        self.addGestureRecognizers()
  
        self.initPageView()
        // Do any additional setup after loading the view.
    }
    
    func initElementsTouchController() {
        self.touchController = ElementsTouchController(mainView: self.view)
    }
    
    func initMenus() {
        self.initPagesManager()
        self.initAddElementsView()
        self.initRightSideBar()
        self.initLeftSideBar()
        
        
    }
    
    func initPageView() {
        let activePage = self.pagesCollection!.activePage;
        activePage!.view.tag = EditViewTags.Page.rawValue
        self.view.insertSubview(activePage!.view, atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addGestureRecognizers() {
        let showPagesManagerGesture = UISwipeGestureRecognizer(target: self, action: "showPagesManager:")
        showPagesManagerGesture.direction = UISwipeGestureRecognizerDirection.Up;
        showPagesManagerGesture.numberOfTouchesRequired = 3;
        self.view.addGestureRecognizer(showPagesManagerGesture)
        
        let swipe3FingersDownGesture = UISwipeGestureRecognizer(target: self, action: "swipe3FingersDown:")
        swipe3FingersDownGesture.direction = UISwipeGestureRecognizerDirection.Down
        swipe3FingersDownGesture.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(swipe3FingersDownGesture)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeftGesture.direction = .Left;
        swipeLeftGesture.numberOfTouchesRequired = 1;
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRightGesture.direction = .Right
        swipeRightGesture.numberOfTouchesRequired = 1;
        self.view.addGestureRecognizer(swipeRightGesture)
    }
    
    func initPagesManager() {
        let pagesManager = PagesManagerViewController(nibName: "PagesManagerViewController", bundle: nil)
        pagesManager.view.tag = EditViewTags.PagesManager.rawValue
        pagesManager.delegate = self
        self.addChildViewController(pagesManager)
        self.pagesManager = pagesManager
    }
    
    func initLeftSideBar() {
//        let leftSideBar      = LeftSideBarViewController(nibName: "LeftSideBarViewController", bundle: nil)
        let leftSideBar = LeftSideBarViewController()
        leftSideBar.tableView.frame = CGRect(x: 0, y: 0, width: 150, height: self.view.frame.height)
        leftSideBar.view.tag = EditViewTags.LeftSideBar.rawValue
        self.addChildViewController(leftSideBar)
        self.leftSideBar  = leftSideBar
    }
    
    func initRightSideBar() {
        
//        let rightSideBar      = RightSideViewController(nibName: "RightSideBarViewController", bundle: nil)
        let rightSideBar = RightSideViewController();
        rightSideBar.view.frame         = CGRect(x: self.view.frame.size.width, y: 0, width: 150, height: self.view.frame.height)
        
        rightSideBar.dataSetsCollection = self.dataSetsCollection
        rightSideBar.tableView.frame    = CGRect(x: UIScreen.mainScreen().bounds.width - 150, y: 40, width: 150, height: self.view.frame.width)
        rightSideBar.view.tag = EditViewTags.LeftSideBar.rawValue
        self.addChildViewController(rightSideBar)
        self.rightSideBar  = rightSideBar
    }
    
    func initAddElementsView() {
        
        let addElements      = AddElementsViewController(nibName: "AddElementsViewController", bundle: nil)
        
        addElements.view.tag = EditViewTags.AddElements.rawValue
        addElements.delegate = self;
        addElements.pagesCollection = self.pagesCollection
        
        self.addChildViewController(addElements)
        self.addElements = addElements
    }
    
    func switchToPage(newPage: Page) {
        
        let currentPageView = self.view.viewWithTag(EditViewTags.Page.rawValue)
        let newPageView     = newPage.view;
        let newCGRect       = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        newPageView.frame = newCGRect
        newPageView.tag = EditViewTags.Page.rawValue
        
        self.view.insertSubview(newPageView, atIndex: 1)
        
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: nil, animations: { () -> Void in
            newPageView.frame.origin.x = 0;
        }) { (Bool) -> Void in
            currentPageView!.removeFromSuperview()
            self.pagesCollection!.activePage = newPage

        }
        
    }
    
    func showPagesManager(gesture: UIGestureRecognizer) {
        let pagesManagerView = self.view.viewWithTag(EditViewTags.PagesManager.rawValue)?
        
        if(pagesManagerView == nil) {
            self.pagesCollection?.activePage?.updateScreenshot()
            self.pagesManager!.updatePagesList()
            self.addAndShowUIViewWithAnimation(self.pagesManager!.view)
        }
        
    }
    
    func hideUIViewWithAnimationAndRemove(viewToHide: UIView) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            viewToHide.alpha = 0
            }, completion: { (Bool) -> Void in
                viewToHide.removeFromSuperview();
        })
        
    }
    
    func addAndShowUIViewWithAnimation(viewToAdd: UIView) {
        viewToAdd.alpha = 0
        
        self.view.addSubview(viewToAdd)
        self.view.bringSubviewToFront(viewToAdd)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            viewToAdd.alpha = 1
        })
        

    }
    
    func hideAddElements() {
        if let addElementsView = self.view.viewWithTag(EditViewTags.AddElements.rawValue) {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                addElementsView.alpha = 0
            })
            
        }
    }
    
    func removeAddElements() {
        if let addElementsView = self.view.viewWithTag(EditViewTags.AddElements.rawValue) {
            addElementsView.removeFromSuperview()
        }
    }
    
    func swipe3FingersDown(gesture: UIGestureRecognizer?) {
        
        if let pagesManagerView = self.view.viewWithTag(EditViewTags.PagesManager.rawValue) {
            self.hideUIViewWithAnimationAndRemove(pagesManagerView)
        } else if let addElementsView = self.view.viewWithTag(EditViewTags.AddElements.rawValue) {
            self.hideUIViewWithAnimationAndRemove(addElementsView)
        } else {
            self.addAndShowUIViewWithAnimation(self.addElements!.view)
        }
    }
    
    
    /* 
     * On swipe left
     * you want to show right side bar 
     * if the left sidebar if visible hide it then
     */
    func swipeLeft(gesture: UIGestureRecognizer) {
         if let leftSideBarView = self.view.viewWithTag(EditViewTags.LeftSideBar.rawValue) {
            self.hideUIViewWithAnimationAndRemove(leftSideBarView)
         } else {
            self.addAndShowUIViewWithAnimation(self.rightSideBar!.view)
        }
    }

    
    /*
     * On swipe right
     * you want to show the left side bar
     * if the right sidebar if visible hide it then
     */
    func swipeRight(gesture: UIGestureRecognizer) {
        if let rightSideBarView = self.view.viewWithTag(EditViewTags.LeftSideBar.rawValue) {
            self.hideUIViewWithAnimationAndRemove(rightSideBarView)
        } else {
            self.addAndShowUIViewWithAnimation(self.leftSideBar!.view)
        }
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
