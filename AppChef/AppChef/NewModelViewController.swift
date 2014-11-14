//
//  NewModelViewController.swift
//  AppChef
//
//  Created by Mark on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit

enum ModelType: Int {
    case API
    case Parse
}

class NewModelViewController: UIViewController, UITextFieldDelegate {
    var appDelegate: AppDelegate?

    var currModelType: ModelType = .API
    
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var NewModelText: UILabel!
    
    @IBOutlet weak var AddData: UIButton!
    @IBOutlet weak var ParseView: UIView!
    @IBOutlet weak var APIView: UIView!
    @IBOutlet weak var apiOrParse: UISegmentedControl!
    @IBOutlet weak var dataSetName: UITextField!
    
    @IBOutlet weak var keysLabel: UILabel!
    @IBOutlet weak var url: UITextField!

    @IBOutlet weak var keyToAdd: UITextField!
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
        keysLabel.text = ""
        keyToAdd.text = ""

    }
    
    @IBAction func selectedModelType(sender: UISegmentedControl) {
        var value = sender.selectedSegmentIndex
        if value == 0 {
            showView(.API)
            self.currModelType = .API
        } else {
            showView(.Parse)
            self.currModelType = .Parse
        }
    }
    
    func showView(toShow: ModelType) {
        APIView.hidden   = true
        ParseView.hidden = true
        
        if toShow == .API {
            APIView.hidden = false
        } else {
            ParseView.hidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        initialiseView()

//        self.dataSetName.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        ParseView.frame.origin.y = 160
        AddData.frame.origin.y = 215
    }
    
    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    
    var _delegate: RightSideViewController?
    
    func setDelegate (delegate: RightSideViewController) {
        _delegate = delegate
    }
    
    @IBAction func Add(sender: AnyObject) {
        println("sdfsdf")
        appDelegate!.dataSetsCollection!.create(dataSetName!.text!, type: self.currModelType, keys: keys)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.view.frame.origin.y = self.view.bounds.height + 500
        }, completion: nil)
        
        _delegate!.dataSetsViewController.tableView.reloadData()
    
    }
    
    
    @IBAction func AddKey(sender: AnyObject) {
        println( keyToAdd.text )
        keys.append(keyToAdd!.text)
        if keys.count > 1 {
            keysLabel.text = "\(keysLabel!.text!), \(keyToAdd!.text!)"
        } else {
            keysLabel.text = "\(keyToAdd!.text!)"
        }
        keyToAdd.text = ""
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