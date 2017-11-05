//
//  LoginManager.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

class LoginManager: RequestManager {
    
    static var config = RequestManagerConfiguration()
    static public let ErrorDomain = "bookshelf.login.manager"
    
    static func login(username: String, password: String, success: @escaping(Bool, Error?) -> ()) {
        
        guard let url = self.URLForResource(resourcePath: "login.php") else {
            
            DispatchQueue.main.async {
                success(false, NSError.invalidPath(ErrorDomain))
            }
            return
        }

        let request = LoginRequest(url: url, username: username, password: password)
        let task = LoginManager.config.session.dataTask(with: request as URLRequest, completionHandler: self.responseDictionaryCheck({ (response, error) in

            DispatchQueue.main.async {
                let successValue = response?["success"] as? Bool ?? false
                success(successValue, error)
            }
            
        }))
        task.resume()
    }
}
