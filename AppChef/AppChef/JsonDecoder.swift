//
//  JsonDecoder.swift
//  JsonTest
//
//  Created by Hackathon on 12/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation
import UIKit

class PlayJsonDecoder: NSObject {
    var json: NSData
    var outputFile: String
    var code: String
    var appDelegate: AppDelegate
    
    init( jsonTemp: NSData, outputFile: String ) {
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        json = jsonTemp
        self.outputFile = outputFile
        code = ""
    }
    
    func parse()
    {
        let jsonD = JSON(data: self.json);
        if( jsonD )
        {
            // Dataset
            let jsonDatasets = jsonD["datasets"].arrayValue
            for jsonDataset in jsonDatasets {
                switch jsonDataset["source"].stringValue {
                case "api":
                    addDatasetApi(jsonDataset)
                case "parse":
                    addDatasetParse(jsonDataset)
                default:
                    println("Unindentified dataset type.")
                }
            }
            
            // Pages
            let jsonPages = jsonD["pages"].arrayValue
            for  jsonPage: JSON in jsonPages {
                var pageId : Int = jsonPage["id"].intValue
                appDelegate.playViewController?.Pages!.create(pageId)
                let prefix = "page"
                let middle = "static"
                for jsonElement in jsonPage["elements"].arrayValue {
                    var elementId = jsonElement["id"].intValue
                    switch jsonElement["type"].stringValue {
                        case "navbar":
                            addNavBar(prefix, id : pageId, navJson: jsonElement, middleOptional:middle, endOptional:"")
                        case "label":
                            addLabel(prefix, id : pageId, labelJson: jsonElement, middleOptional:middle, endOptional:"")
                        case "button":
                            addButton(prefix, id : pageId, buttonJson: jsonElement, middleOptional:middle, endOptional:"")
                        case "list":
                            addList(prefix, id : pageId, listJson: jsonElement)
                        case "inputField":
                            addInputField(prefix, id : pageId, inputJson: jsonElement, middleOptional:middle, endOptional:"")
                        case "textBox":
                            addTextBox(prefix, id : pageId, textBoxJson: jsonElement, middleOptional:middle, endOptional:"")
                        default:
                            println("Unindentified element.")
                    }
                }
            }
            
        }
        else {
            println("error")
            println(jsonD)
        }
    }
    
    func addNavBar( prefix : String, id: Int, navJson: JSON, middleOptional : String, endOptional : String ) {
        let text = navJson["text"]
        let navId = navJson["id"]
        appDelegate.playViewController?.Pages!.getPage(id)!.Elements!.addNavBar(id, text: text.stringValue)
        let prefixNavEl = "Pages!.getPage"
        let middleOptional = "NavBar"
        var endOptional = Place.Left;
        
        let buttonLeft = navJson["buttons"]["left"]
        if( buttonLeft)
        {
            addNavButton(prefix, id: id, buttonJson: buttonLeft, middleOptional: middleOptional, endOptional: endOptional)
        }
        
        
        endOptional = .Right
        
        let buttonright = navJson["buttons"]["right"]
        if( buttonright)
        {
            addNavButton(prefix, id: id, buttonJson: buttonright, middleOptional: middleOptional, endOptional: endOptional)
        }
    }
    
    func addNavButton( prefix : String, id: Int, buttonJson: JSON, middleOptional : String, endOptional : Place ) {
        let buttonId = buttonJson["id"].intValue
        let text = buttonJson["text"]
        appDelegate.playViewController?.Pages!.getPage(id)!.Elements!.addNavBarButton(buttonId, text: text.stringValue, place: endOptional )
        
        if buttonJson["onClick"] {
            let action = buttonJson["onClick"]["action"]
            switch action.stringValue {
            case "goToPage":
                addActionNavigateToButton(prefix, id: id, idButton: buttonId, actionJson: buttonJson["onClick"])
            case "add":
                addActionAddToButton(prefix, id: id, idButton: buttonId, actionJson: buttonJson["onClick"])
            default:
                println("Action unrecognised.")
            }
        }
        
    }
    
    func addButton( prefix : String, id: Int, buttonJson: JSON, middleOptional : String, endOptional : String ) {
        let buttonId = buttonJson["id"].intValue
        let color = buttonJson["color"]
        let pos = getPosition(buttonJson)
        let radius = buttonJson["radius"]
        if let text = buttonJson["text"].string {
            appDelegate.playViewController?.Pages!.getPage(id)!.Elements!.addStaticButton(buttonId, text:text,size: pos)
        }
        else
        {
            let textSource = buttonJson["textSource"].stringValue
            appDelegate.playViewController?.Pages!.getPage(id)!.Elements!.addStaticButton(buttonId, text: textSource, size: pos)
        }
        
        if buttonJson["onClick"] {
            let action = buttonJson["onClick"]["action"]
            switch action.stringValue {
                case "goToPage":
                    addActionNavigateToButton(prefix, id: id, idButton: buttonId, actionJson: buttonJson["onClick"])
                case "add":
                    addActionAddToButton(prefix, id: id, idButton: buttonId, actionJson: buttonJson["onClick"])
                default:
                    println("Action unrecognised.")
            }
        }
    }
    
    func addActionAddToButton(prefix : String, id: Int, idButton: Int, actionJson: JSON)
    {
        let dataSetId = actionJson["dataset"]
        var dic : [String:Int] = [:]
        for itemToAdd in actionJson["itemsToAdd"].arrayValue {
            var key = itemToAdd["key"].stringValue
            var idSource = itemToAdd["source"].intValue
            dic[key] = idSource
        }
        
        appDelegate.playViewController?.Pages?.getPage(id)!.addAction(idButton, addToDataSet: dataSetId.intValue, itemsToAdd: dic )
    }
    
    func addActionNavigateToButton(prefix : String, id: Int, idButton: Int, actionJson: JSON)
    {
        let pageId = actionJson["pageId"].intValue
        appDelegate.playViewController?.Pages?.getPage(id)!.addAction(idButton, navigateTo:pageId)
    }
    
    func addLabel(prefix : String, id: Int, labelJson: JSON, middleOptional : String, endOptional : String) {
        let labelId = labelJson["id"]
        let color = labelJson["color"]
        let text = labelJson["text"]
        let pos = getPosition(labelJson)
        if let text = labelJson["text"].string {
            appDelegate.playViewController?.Pages?.getPage(id)!.Elements!.addStaticLabel(labelId.intValue, text :text, size:pos )
        }
        else
        {
            let textSource = labelJson["textSource"]
            
            appDelegate.playViewController!.Pages!.getPage(id)!.Elements!.addStaticLabel(labelId.intValue, text: textSource.stringValue, size: pos)
//            appDelegate.playViewController?.Pages?.getPage(id)!.Elements!.addStaticLabel(labelId.intValue, key: textSource, size: pos)
        }
    }
    
    func addImage(prefix : String, id: Int, imageJson: JSON, middleOptional : String, endOptional : String) {
        let imageId = imageJson["id"]
        let textSource = imageJson["textSource"]
        let pos = getPosition(imageJson)
        appDelegate.playViewController?.Pages?.getPage(id)!.Elements!.addDynamicImage(imageId.intValue, key: textSource.stringValue, size: pos)

    }
    
    func addInputField(prefix : String, id: Int, inputJson : JSON, middleOptional : String, endOptional : String) {
        let inputId = inputJson["id"]
        let pos = getPosition(inputJson)
        let radius = inputJson["radius"]
        let backgroundColor = inputJson["backgroundColor"]
        let placeHolder = inputJson["placeholder"]
        //appDelegate.playViewController?.Pages?.getPage(id).!Elements.addStaticInputField(inputId, size: pos, radius: \(radius), backgroundColor: \(backgroundColor), placeHolder: \"\(placeHolder)\" )\n"
    }
    
    func addTextBox(prefix : String, id: Int, textBoxJson : JSON, middleOptional : String, endOptional : String) {
        let inputId = textBoxJson["id"]
        let pos = getPosition(textBoxJson)
        let radius = textBoxJson["radius"]
        let backgroundColor = textBoxJson["backgroundColor"]
        let placeHolder = textBoxJson["placeholder"]
        //appDelegate.playViewController?.Pages?.getPage(id).!Elements.addStaticTextBox(inputId, size: pos, radius: \(radius), backgroundColor: \(backgroundColor), placeHolder: \"\(placeHolder)\" )\n"
    }
    
    func getPosition(json: JSON ) -> CGRect {
        let posx  = json["frame"]["x"].intValue
        let posy  = json["frame"]["y"].intValue
        var width = json["frame"]["width"].intValue
        var height = json["frame"]["height"].intValue
        
        return CGRect( x: Int(posx), y: Int(posy), width: Int(width), height: Int(height) )
    }
    
    func addList(prefix : String, id: Int, listJson:JSON) {
        let tableId = listJson["id"].intValue
        let pos = getPosition(listJson)
        let tableSource = listJson["source"].intValue
        
        appDelegate.playViewController?.Pages!.getPage(id)!.addList(tableId, source: tableSource, size: pos )
        let cellsJson = listJson["cell"].arrayValue
        let prefixCells = "Lists!.getList"
        let middle = "Dynamic"
        
        for cell in cellsJson {
            let source = cell["textSource"]
            let endOptional = ", source: \(source)"
            switch cell["type"].stringValue {
                case "label":
                    addLabel(prefixCells, id : tableId, labelJson: cell, middleOptional:middle, endOptional: endOptional)
                case "image":
                    addImage(prefixCells, id : tableId, imageJson: cell, middleOptional:middle, endOptional: endOptional)
                case "button":
                    addButton(prefixCells, id : tableId, buttonJson: cell, middleOptional:middle, endOptional: endOptional)
                case "list":
                    addList(prefixCells, id : tableId, listJson: cell)
                case "inputField":
                    addInputField(prefixCells, id : tableId, inputJson: cell, middleOptional:middle, endOptional: endOptional)
                case "textBox":
                    addTextBox(prefixCells, id : tableId, textBoxJson: cell, middleOptional:middle, endOptional: endOptional)
                default:
                    println("Unindentified element.")
            }
            
        }
    }
    
    func addDatasetApi(jsonDataset : JSON) {
        let datasetId = jsonDataset["id"].intValue
        let name = jsonDataset["name"].stringValue
        let link = jsonDataset["link"].stringValue
        let keys = jsonDataset["keys"].arrayValue
        var array : [String] = []
        for el in keys {
            array.append(el.stringValue)
        }
        
        appDelegate.playViewController?.DataSets!.create(datasetId, name: name, API: link, keys: array)
    
    }
    
    func addDatasetParse(jsonDataset: JSON ) {
        let datasetId = jsonDataset["id"].intValue
        let name = jsonDataset["name"].stringValue
        let keys = jsonDataset["keys"].arrayValue
        
        var array : [String] = []
        for el in keys {
            array.append(el.stringValue)
        }
        
        appDelegate.playViewController?.DataSets!.create(datasetId, name: name, keys: array)
    }
    
    
}

