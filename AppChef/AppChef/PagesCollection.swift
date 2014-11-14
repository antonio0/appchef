//
//  PagesCollection.swift
//  AppChef
//
//  Created by Bartlomiej Siemieniuk on 13/11/2014.
//  Copyright (c) 2014 TeamGoat. All rights reserved.
//

import Foundation

class PagesCollection {
    
    var pages : [Page] = []
    var activePage : Page?
    
    init() {
        self.activePage = self.addPage()
    }
    
    func addPage() -> Page {
        let newPage = Page()
        self.pages.append(newPage)
        return newPage
    }
    
    func toJSON() {
        
    }
    
}