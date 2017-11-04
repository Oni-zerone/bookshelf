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
    
    static func getAuthors(for page: Int = 0, session: URLSession = Config.session, completion: @escaping(Int, Array<Author>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "authors.php", with: ["page" : "\(page)"]) else {
            
            return completion(page, nil, NSError.invalidPath(ErrorDomain))
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseDictionaryCheck({ (response, error) in
            
            if let e = error {
                
                return completion(page, NSNotFound, nil, e)
            }
            
            guard let responsePage = response?["page"] as? Int,
                let items = response?["authors"] as? Array<Dictionary<String, Any>> else {
                
                return completion(page, nil, NSError.invalidContent(ErrorDomain))
            }
            
            let authors = items.flatMap({ (item) -> Author? in
                return Author(resource: item)
            })
            
            completion(responsePage, authors, nil)
        }))
        
        task.resume()
    }
}
