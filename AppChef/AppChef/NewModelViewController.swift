//
//  NewModelViewController.swift
//  AppChef
//
//  Created by Mark on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

enum Show: Int {
    case API
    case Parse
}

class NewModelViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var NewModelText: UILabel!
    
    @IBOutlet weak var AddData: UIButton!
    @IBOutlet weak var ParseView: UIView!
    @IBOutlet weak var APIView: UIView!
    @IBOutlet weak var apiOrParse: UISegmentedControl!
    @IBOutlet weak var dataSetName: UITextField!
    
    var keys: [String] = []
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method
        textField.becomeFirstResponder();
    }
    
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return false
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        println("clicked return ");
        userText.resignFirstResponder();
//        self.view.endEditing(true);
//        self.dataSetName.resignFirstResponder();
        return false;
    }
    
    func initialiseView() {
        showView(.API)
    }
    
    @IBAction func selectedModelType(sender: UISegmentedControl) {
        var value = sender.selectedSegmentIndex
        if value == 0 {
            showView(.API)
        } else {
            showView(.Parse)
        }
    }
    
    func showView(toShow: Show) {
        APIView.hidden   = true
        ParseView.hidden = true
        
        if toShow == .API {
            APIView.hidden = false
//            AddData.frame.origin.y = 209 - 27
//            AddData.frame.origin.y = 160
        } else {
            ParseView.hidden = false
//            AddData.frame.origin.y = 209
            ParseView.frame.origin.y = 160
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
//        self.dataSetName.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func Add(sender: AnyObject) {
    }
    
    @IBAction func AddKey(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        recurseView(self.view);
    }
    
    func recurseView(view: UIView) {
        for subview in view.subviews {
            self.recurseView(subview as UIView);
        }
        view.resignFirstResponder();
    }
}