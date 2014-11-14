//
//  JsonDecoder.swift
//  JsonTest
//
//  Created by Hackathon on 12/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation

class JsonDecoder {
    var json: NSData
    var outputFile: String
    var code: String
    
    init( jsonTemp: NSData, outputFile: String ) {
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
            let jsonDatasets = jsonD["datasets"].arrayValue!
            for jsonDataset in jsonDatasets {
                switch jsonDataset["source"].stringValue! {
                case "api":
                    addDatasetApi(jsonDataset)
                case "parse":
                    addDatasetParse(jsonDataset)
                default:
                    println("Unindentified dataset type.")
                }
            }
            
            // Pages
            let jsonPages = jsonD["pages"].arrayValue!
            for  jsonPage: JSON in jsonPages {
                var pageId : Int = jsonPage["id"].integerValue!
                code = "\(code)Pages!.create(\(pageId))\n"
                let prefix = "Pages!.getPage"
                let middle = "Static"
                for jsonElement in jsonPage["elements"].arrayValue! {
                    var elementId = jsonElement["id"].integerValue
                    switch jsonElement["type"].stringValue! {
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
        code.writeToFile(outputFile, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    func addNavBar( prefix : String, id: Int, navJson: JSON, middleOptional : String, endOptional : String ) {
        let text = navJson["text"]
        let navId = navJson["id"]
        code = "\(code)\(prefix)(\(id))!.Elements!.addNavBar(\(navId), text: \"\(text)\")\n"
        let prefixNavEl = "Pages!.getPage"
        let middleOptional = "NavBar"
        var endOptional = ", place: .Left"
        let buttonLeft = navJson["buttons"]["left"]
        if( buttonLeft)
        {
            addNavButton(prefix, id: id, buttonJson: buttonLeft, middleOptional: middleOptional, endOptional: endOptional)
        }
        
        
        endOptional = ", place: .Right"
        let buttonright = navJson["buttons"]["right"]
        if( buttonright)
        {
            addNavButton(prefix, id: id, buttonJson: buttonright, middleOptional: middleOptional, endOptional: endOptional)
        }
    }
    
    func addNavButton( prefix : String, id: Int, buttonJson: JSON, middleOptional : String, endOptional : String ) {
        let buttonId = buttonJson["id"].integerValue!
        let text = buttonJson["text"]
        code = "\(code)\(prefix)(\(id))!.Elements!.add\(middleOptional)Button(\(buttonId), text:\"\(text)\"\(endOptional) )\n"
        
        if buttonJson["onClick"] {
            let action = buttonJson["onClick"]["action"]
            switch action.stringValue! {
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
        let buttonId = buttonJson["id"].integerValue!
        let color = buttonJson["color"]
        let pos = getPosition(buttonJson)
        let radius = buttonJson["radius"]
        if let text = buttonJson["text"].stringValue {
            code = "\(code)\(prefix)(\(id))!.Elements.addStaticButton(\(buttonId), text:\"\(text)\", color: \"\(color)\", size: \(pos), radius: \(radius) )\n"
        }
        else
        {
            let textSource = buttonJson["textSource"]
            code = "\(code)\(prefix)(\(id))!.Elements.addStaticButton(\(buttonId), textSource: \"\(textSource)\", color: \"\(color)\", size: \(pos), radius: \(radius) )\n"
        }
        
        if buttonJson["onClick"] {
            let action = buttonJson["onClick"]["action"]
            switch action.stringValue! {
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
        code = "\(code)\(prefix)(\(id))!.addAction(\(idButton), addToDataSet: \(dataSetId), itemsToAdd: [ "
        var first = true
        for itemToAdd in actionJson["itemsToAdd"].arrayValue! {
            if first == false {
                code = "\(code), "
            }
            let key = itemToAdd["key"]
            let idSource = itemToAdd["source"]
            code = "\(code)\"\(key)\":\(idSource)"
            first = false
        }
        code = "\(code)])\n"
    }
    
    func addActionNavigateToButton(prefix : String, id: Int, idButton: Int, actionJson: JSON)
    {
        let pageId = actionJson["pageId"].integerValue!
        code = "\(code)\(prefix)(\(id))!.addAction(\(idButton), navigateTo:\(pageId))\n"
    }
    
    func addLabel(prefix : String, id: Int, labelJson: JSON, middleOptional : String, endOptional : String) {
        let labelId = labelJson["id"]
        let color = labelJson["color"]
        let text = labelJson["text"]
        let pos = getPosition(labelJson)
        if let text = labelJson["text"].stringValue {
            code = "\(code)\(prefix)(\(id))!.Elements.add\(middleOptional)Label(\(labelId), text:\"\(text)\", color:\"\(color)\", size:\(pos) )\n"
        }
        else
        {
            let textSource = labelJson["textSource"]
            code = "\(code)\(prefix)(\(id))!.Elements.add\(middleOptional)Label(\(labelId), key:\"\(textSource)\", color:\"\(color)\", size:\(pos) )\n"
        }
    }
    
    func addImage(prefix : String, id: Int, imageJson: JSON, middleOptional : String, endOptional : String) {
        let imageId = imageJson["id"]
        let textSource = imageJson["textSource"]
        let pos = getPosition(imageJson)
        code = "\(code)\(prefix)(\(id))!.Elements.addDynamicImage(\(imageId), key:\"\(textSource)\", size:\(pos) )\n"

    }
    
    func addInputField(prefix : String, id: Int, inputJson : JSON, middleOptional : String, endOptional : String) {
        let inputId = inputJson["id"]
        let pos = getPosition(inputJson)
        let radius = inputJson["radius"]
        let backgroundColor = inputJson["backgroundColor"]
        let placeHolder = inputJson["placeholder"]
        code = "\(code)\(prefix)(\(id)).!Elements.add\(middleOptional)InputField(\(inputId), size: \(pos), radius: \(radius), backgroundColor: \(backgroundColor), placeHolder: \"\(placeHolder)\" )\n"
    }
    
    func addTextBox(prefix : String, id: Int, textBoxJson : JSON, middleOptional : String, endOptional : String) {
        let inputId = textBoxJson["id"]
        let pos = getPosition(textBoxJson)
        let radius = textBoxJson["radius"]
        let backgroundColor = textBoxJson["backgroundColor"]
        let placeHolder = textBoxJson["placeholder"]
        code = "\(code)\(prefix)(\(id)).!Elements.add\(middleOptional)TextBox(\(inputId), size: \(pos), radius: \(radius), backgroundColor: \(backgroundColor), placeHolder: \"\(placeHolder)\" )\n"
    }
    
    func getPosition(json: JSON ) -> String {
        let posx = json["frame"]["x"]
        let posy = json["frame"]["y"]
        var width = json["frame"]["width"].stringValue!
        if width == "full Width" {
            width = "self.view.bounds.width"
        }
        var height = json["frame"]["height"].stringValue!
        if height == "full Height" {
            height = "self.view.bounds.height"
        }
        return "CGRect(x:\(posx), y:\(posy), width:\(width), height:\(height))"
    }
    
    func addList(prefix : String, id: Int, listJson:JSON) {
        let tableId = listJson["id"].integerValue!
        let pos = getPosition(listJson)
        let tableSource = listJson["source"]
        code = "\(code)\(prefix)(\(id))!.addList(\(tableId), source: \(tableSource), size: \(pos))\n"
        let cellsJson = listJson["cell"].arrayValue!
        let prefixCells = "Lists!.getList"
        let middle = "Dynamic"
        
        for cell in cellsJson {
            let source = cell["textSource"]
            let endOptional = ", source: \(source)"
            switch cell["type"].stringValue! {
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
        let datasetId = jsonDataset["id"]
        let name = jsonDataset["name"]
        let link = jsonDataset["link"]
        let keys = jsonDataset["keys"].arrayValue!
        var command = "DataSets!.create(\(datasetId), name: \"\(name)\", API:\"\(link)\", keys: ["
        if keys.count > 0 {
            command = "\(command)\"\(keys[0])\""
        }
        for var keyId = 1; keyId < keys.count; keyId++ {
            command = "\(command) ,\"\(keys[keyId])\""
        }
        command = "\(command)])\n"
        code = "\(code)\(command)"
    
    }
    
    func addDatasetParse(jsonDataset: JSON ) {
        let datasetId = jsonDataset["id"]
        let name = jsonDataset["name"]
        let keys = jsonDataset["keys"].arrayValue!
        var command = "DataSets!.create(\(datasetId), name: \"\(name)\", keys: ["
        if keys.count > 0 {
            command = "\(command)\"\(keys[0])\""
        }
        for var keyId = 1; keyId < keys.count; keyId++ {
            command = "\(command) ,\"\(keys[keyId])\""
        }
        command = "\(command)])\n"
        code = "\(code)\(command)"
    }
    
    
}

