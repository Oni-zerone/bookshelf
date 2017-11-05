//
//  LoginRequest.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

class LoginRequest: NSMutableURLRequest {
    
    init(url URL: URL, username: String, password: String) {
        super.init(url: URL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 0)
        
        self.initialize()
        let postString = "Username=\(username)&Password=\(password)"
        self.httpBody = postString.data(using: .utf8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }
    
    private func initialize() {
        
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        self.httpMethod = "POST"
    }
}
