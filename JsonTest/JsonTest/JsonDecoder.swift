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
            // Pages
            let jsonPages = jsonD["pages"].arrayValue!
            for  jsonPage: JSON in jsonPages {
                var pageId : Int = jsonPage["id"].integerValue!
                code = "\(code)Pages!.create(\(pageId))\n"
                let prefix = "Pages!.getPage"
                for jsonElement in jsonPage["elements"].arrayValue! {
                    var elementId = jsonElement["id"].integerValue
                    switch jsonElement["type"].stringValue! {
                        case "label":
                            addLabel(prefix, id : pageId, labelJson: jsonElement)
                        case "button":
                            addButton(prefix, id : pageId, buttonJson: jsonElement)
                        case "list":
                            addList(prefix, id : pageId, listJson: jsonElement)
                        case "inputField":
                            addInputField(prefix, id : pageId, inputJson: jsonElement)
                        case "textBox":
                            addTextBox(prefix, id : pageId, textBoxJson: jsonElement)
                        default:
                            println("Unindentified element.")
                    }
                }
            }
            
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
        }
        else {
            println("error")
            println(jsonD)
        }
        code.writeToFile(outputFile, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    func addButton( prefix : String, id: Int, buttonJson: JSON) {
        let buttonId = buttonJson["id"]
        let color = buttonJson["color"]
        let text = buttonJson["text"]
        let pos = getPosition(buttonJson)
        let radius = buttonJson["radius"]
        code = "\(code)\(prefix)(\(id)).Elements.addButton(\(buttonId), \"\(text)\", \"\(color)\", \(pos), \(radius) )\n"
    }
    
    func addLabel(prefix : String, id: Int, labelJson: JSON) {
        let labelId = labelJson["id"]
        let color = labelJson["color"]
        let text = labelJson["text"]
        let pos = getPosition(labelJson)
        code = "\(code)\(prefix)(\(id)).Elements.addLabel(\(labelId), \"\(text)\", \"\(color)\", \(pos) )\n"
    }
    
    func addInputField(prefix : String, id: Int, inputJson : JSON ) {
        let inputId = inputJson["id"]
        let pos = getPosition(inputJson)
        let radius = inputJson["radius"]
        let backgroundColor = inputJson["backgroundColor"]
        let placeHolder = inputJson["placeholder"]
        code = "\(code)\(prefix)(\(id)).Elements.addInputField(\(inputId), \(pos), \(radius), \(backgroundColor), \"\(placeHolder)\" )\n"
    }
    
    func addTextBox(prefix : String, id: Int, textBoxJson : JSON ) {
        let inputId = textBoxJson["id"]
        let pos = getPosition(textBoxJson)
        let radius = textBoxJson["radius"]
        let backgroundColor = textBoxJson["backgroundColor"]
        let placeHolder = textBoxJson["placeholder"]
        code = "\(code)\(prefix)(\(id)).Elements.addTextBox(\(inputId), \(pos), \(radius), \(backgroundColor), \"\(placeHolder)\" )\n"
    }
    
    func getPosition(json: JSON ) -> String {
        let posx = json["frame"]["x"]
        let posy = json["frame"]["y"]
        let width = json["frame"]["width"]
        let height = json["frame"]["height"]
        return "CGRect(\(posx), \(posy), \(width), \(height))"
    }
    
    func addList(prefix : String, id: Int, listJson:JSON) {
        let tableId = listJson["id"]
        let cellsJson = listJson["cell"].arrayValue!
        let prefixCells = "Lists!.getList"
        for cell in cellsJson {
            let name = cell["name"]
        }
    }
    
    func addDatasetApi(jsonDataset : JSON ) {
        let datasetId = jsonDataset["id"]
        let name = jsonDataset["name"]
        let link = jsonDataset["link"]
        let keys = jsonDataset["keys"].arrayValue!
        var command = "Datasets!.create(id: \(datasetId), name: \"\(name)\", API:\"\(link)\"), keys: ["
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
        var command = "Datasets!.create(id: \(datasetId), name: \"\(name)\", keys: ["
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

