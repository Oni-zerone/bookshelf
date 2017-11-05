//
//  BooksManager.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

typealias BooksManager = APIManager

extension APIManager {
    
    static func getBooks(for authorId: Int, session: URLSession = Config.session, completion: @escaping(Int, Array<Book>?, Error?) -> ()) {
        
        guard let URL = APIManager.URLForResource(resourcePath: "books.php", with: ["author" : "\(authorId)"]) else {
            
            return completion(authorId, nil, NSError.invalidPath(ErrorDomain))
        }
        
        let task = session.dataTask(with: APIRequest(url: URL) as URLRequest, completionHandler: APIManager.responseDictionaryCheck({ (response, error) in
            
            if let e = error {
                
                return completion(authorId, nil, e)
            }
            
            guard let author = response?["author"] as? Int,
                let items = response?["books"] as? Array<Dictionary<String, Any>> else {
                    
                    return completion(authorId, nil, NSError.invalidContent(ErrorDomain))
            }
            
            let books = items.flatMap({ (item) -> Book? in
                return Book(resource: item)
            })
            
            completion(author, books, nil)
        }))
        
        task.resume()
    }
    
}
