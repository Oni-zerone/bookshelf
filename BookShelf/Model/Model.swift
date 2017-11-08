//
//  Model.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class Model: NSObject {

    private static let domain = "Model"
    
    static let shared: Model = Model()
    private static let queue = DispatchQueue(label: "it.studiout.bookshelf.modelQueue")

    private var authorsCache: Set<Author>?
    private var booksCache = Dictionary<Int, Set<Book>>()
}


typealias AuthorsModel = Model
extension AuthorsModel {
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
                    completion(nil, NSError.invalidContent(Model.domain))
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

typealias BooksModel = Model
extension BooksModel {
    
    func getBooks(for author: Author, completion: @escaping (Set<Book>?, Error?) -> Void) {
     
        Model.queue.async {
            
            if let books = self.booksCache[author.id] {
                DispatchQueue.main.async {
                    completion(books, nil)
                }
                return
            }
            
            self.loadBooks(for: author, completion: { (books, error) in
                
                if let books = books {
                    self.booksCache[author.id] = books
                }
                DispatchQueue.main.async {
                    completion(books, nil)
                }
            })
        }
    }
    
    private func loadBooks(for author:Author, completion: @escaping (Set<Book>?, Error?) -> Void) {
        
        APIManager.getBooks(for: author.id) { (authorId, books, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard author.id == authorId,
                let books = books else {
                completion(nil, NSError.invalidContent(Model.domain))
                return
            }
            
            var booksSet = Set<Book>()
            booksSet.insertContents(of: books)
            completion(booksSet, nil)
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
