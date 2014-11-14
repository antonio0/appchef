//
//  main.swift
//  JsonTest
//
//  Created by Hackathon on 12/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import Foundation

let fileName = Process.arguments[1]
let outFile = Process.arguments[2]

let data: NSData? = NSData(contentsOfFile: fileName)

var decoder = JsonDecoder(jsonTemp: data!, outputFile: outFile);
decoder.parse();



