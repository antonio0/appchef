//
//  Image.swift
//  GeneratedApp
//
//  Created by Mark on 13/11/2014.
//  Copyright (c) 2014 Team Goat. All rights reserved.
//

import UIKit
import Alamofire

class Image {
    
    init () {
        
    }
    
    class func download(url: NSURL, handler: ((image: UIImage, NSError!) -> Void))
    {
        var imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{response, data, error in
                handler(image: UIImage(data: data)!, error)
        })
    }
    
    
}