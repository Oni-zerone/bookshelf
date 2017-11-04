//
//  Model.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class Model: NSObject {

    static let shared: Model = Model()
    private static let queue = DispatchQueue(label: "it.studiout.bookshelf.modelQueue")

    private var authorsCache: Set<Author>?
    
    func getAuthors(completion: @escaping (Set<Author>?, Error?) -> Void) {
        
        Model.queue.async {
            if let authors = self.authorsCache {
                DispatchQueue.main.async {
                    completion(authors, nil)
                }
                return
            }
            
            self.loadAuthors { (authors, error) in
                self.authorsCache = authors
                
                DispatchQueue.main.async {
                    completion(authors, error)
                }
            }
        }
    }
    
    private func loadAuthors(completion: @escaping (Set<Author>?, Error?) -> Void) {
     
        APIManager.getAuthorsPageCount { (count, error) in
            
            guard count != NSNotFound else {
                completion(nil, error)
                return
            }
            
            self.loadAuthors(in: count, completion: { (authors) in
                
                guard authors.count > 0 else {
                    completion(nil, NSError.invalidContent(String(describing: self.classForCoder)))
                    return
                }
                
                completion(authors, nil)
            })
            
        }
    }
    
    private func loadAuthors(in pages:Int, completion: @escaping (Set<Author>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var resultAuthors = Set<Author>()
        for page in 0..<pages {
            
            dispatchGroup.enter()
            APIManager.getAuthors(for: page, completion: { (resultPage, authors, error) in
                
                defer {
                    dispatchGroup.leave()
                }
                
                guard page == resultPage,
                    error == nil,
                    let authors = authors else {
                        
                    return
                }
                
                resultAuthors.insertContents(of: authors)
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .background)) {
            completion(resultAuthors)
        }
    }
}

fileprivate extension Set {
    
    mutating func insertContents(of array: Array<Element>) {
        array.forEach { (item) in
            self.insert(item)
        }
    }
    
}
