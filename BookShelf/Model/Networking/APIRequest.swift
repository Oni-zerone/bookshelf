//
//  APIRequest.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

internal class APIRequest: NSMutableURLRequest {
    
    required override init(url URL: URL, cachePolicy: NSURLRequest.CachePolicy, timeoutInterval: TimeInterval) {
        
        super.init(url: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        
        addValue("application/json", forHTTPHeaderField: "Accept")
        addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
