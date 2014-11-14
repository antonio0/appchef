//
//  BindElementModelController.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 14/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation
import UIKit


enum BindingType: Int {
    case Add
    case SetSource
    case SetDisplay
}
class BindElementModelController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    var currBindingType: BindingType = .Add
    
    var appDelegate: AppDelegate?
    var bindings: Bindings?
    
    @IBOutlet weak var setAsSourceView: UIView!
    @IBOutlet weak var selectAction: UISegmentedControl!
    @IBOutlet weak var addToDSView: UIView!
    @IBOutlet weak var allBindings: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
        bindings    = appDelegate!.bindings
        picker.delegate = self
//        picker.selectedRowInComponent(1)
    }

    

//    @IBAction func createAddAction(sender: AnyObject) {
//// bindings?.addSourceBinding(dataSet: currDS!, el ement: currElement, key: "addToDataSet")
//// appDelegate!.elements.getElement(currElement).createAddToDataSourceAction(currDataSource)
//    }
    var currDataSource: Int?
    var currElement: Int?
    
    var myBindings: [String: Int]?
    
    func initialiseView() {
        showView(.Add)
    }
    
    func showView(toShow: BindingType) {
        setAsSourceView.hidden   = true
        addToDSView.hidden = true
        
        if toShow == .Add {
            addToDSView.hidden = false
        } else if toShow == .SetSource {
            setAsSourceView.hidden = false
        }
        
        currBindingType = toShow
        
    }
    
    override func viewDidLayoutSubviews() {
        setAsSourceView.frame.origin.y = 138
        addToDSView.frame.origin.y = 138
    }
    
    var _actionKeyToAdd: String?
    
    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate?
//        println("sdfssdfsdfsdfsdfsd")
//
//        bindings    = appDelegate!.bindings
//        println("sdfs")
////        picker.delegate = self
//        println("yoyoyo")
//
//        // Do any additional setup after loading the view.
//    }
//    
//    

  
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var ds = appDelegate!.dataSetsCollection!.datasets[currDataSource!]
        var values = ds!.keys
        return values[row]
        //        var values = [String](myBindings!.keys)
//        return values[row]
//        return "lol"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var ds = appDelegate!.dataSetsCollection!.datasets[currDataSource!]
        var values = ds!.keys
        _actionKeyToAdd = values[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var ds = appDelegate!.dataSetsCollection!.datasets[currDataSource!]
        var values = ds!.keys
        return values.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func viewChanged(sender: AnyObject) {
        var value = sender.selectedSegmentIndex
        if value == 0 {
            showView(.Add)
        } else if value == 1 {
            showView(.SetSource)
        }
    }
    
    @IBAction func addElementBinding(sender: AnyObject) {
        if _actionKeyToAdd != nil {
            bindings!.addSourceBinding(currDataSource!, element: currElement!, key: _actionKeyToAdd!)
        }
    }

    
  
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        initialiseView()
        println("got here")
        myBindings = bindings!._sourceBindings[currDataSource!]
        println("yoyo")
        if myBindings != nil {
            for key in myBindings!.keys {
                if allBindings.text == "" {
                    allBindings.text = "\(key)"
                } else {
                    allBindings.text = "\(allBindings.text), \(key)"
                }
            }
        }
    }
    
//
//    
    @IBAction func createAddAction(sender: AnyObject) {
        //bindings?.addSourceBinding(dataSet: currDS!, element: currElement, key: "addToDataSet")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}