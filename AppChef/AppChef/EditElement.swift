//
//  EditElement.swift
//  AppChef
//
//  Created by Mark on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

class EditElement: UIViewController {
    
    @IBOutlet weak var pageLinkVal: UILabel!
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        // Initialize variables.
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func stepper(sender: UIStepper) {
        pageLinkVal.text = Int(sender.value).description
    }
    
    @IBOutlet weak var textField: UITextField!
    var _delegate: ElementsTouchController?
    
    func setDelegate(delegate: ElementsTouchController) {
        _delegate = delegate
    }
    
    var elementEditing: Element?
    
    func setElement (element: Element?) {
        elementEditing = element
    }
    
    var pages: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate        = UIApplication.sharedApplication().delegate as AppDelegate
        let pagesCollection    = appDelegate.pagesCollection!;
//        let pagesCollection    = appDelegate.pagesCollection!;
        var count = 0
        
        pages = pagesCollection.pageIds
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(sender: AnyObject) {
        
        if elementEditing == nil {
            return
        }
        
        if elementEditing!.uiElement is UIButton {
            var elm = elementEditing!.uiElement as UIButton
            elm.setTitle(textField.text, forState: .Normal)
            
        } else if elementEditing!.uiElement is UILabel {
            var elm = elementEditing!.uiElement as UILabel

            elm.text = textField.text
        }
        
        _delegate!.closeModal()
        
        if pageLinkVal.text!.toInt() != 0 {
            var pageid: Int = pages[pageLinkVal.text!.toInt()!]
            //fuck you swift
            elementEditing!.addAction( pageid
            )
        }
        
        
    }
    
    
    
    
    
}