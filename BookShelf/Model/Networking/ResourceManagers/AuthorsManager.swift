//
//  AuthorsManager.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

typealias AuthorsManager = APIManager

extension AuthorsManager {
    
    static func getAuthors(for page: Int = 0, session: URLSession = Config.session, completion: @escaping(Array<Author>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "authors.php", with: ["page" : "\(page)"]) else {
            
            return completion(nil, NSError.invalidPath(ErrorDomain))
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseArrayCheck({ (response, error) in
            
            if let e = error {
                
                return completion(nil, e)
            }
            
            guard let items = response as? Array<Dictionary<String, Any>> else {
                
                return completion(nil, NSError.invalidContent(ErrorDomain))
            }
            
            let ingredients = items.flatMap({ (item) -> Author? in
                return Author(resource: item)
            })
            
            completion(ingredients, nil)
        }))
        
        task.resume()
    }
}
