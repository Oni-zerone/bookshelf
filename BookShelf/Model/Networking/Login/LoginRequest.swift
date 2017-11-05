//
//  LoginRequest.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

class LoginRequest: NSMutableURLRequest {
    
    init?(url URL: URL, username: String, password: String) {
        super.init(url: URL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 0)
        
        self.initialize()
        do {
            self.httpBody = try JSONSerialization.data(withJSONObject: ["Username" : username,
                                                                        "Password" : password],
                                                       options: .sortedKeys)
        } catch  {
            return nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }
    
    private func initialize() {
        
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpMethod = "POST"
    }
}
