//
//  Book.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

struct Book {
    
    let ISBN: Int
    let title: String
    let editor: String
    let series: String
    let year: Int
    let pages: Int
    let price: Double
    let discount: Double
    let imageURL: URL?
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let ISBN = resources["ISBN"] as? Int,
            let title = resources["title"] as? String,
            let editor = resources["editor"] as? String,
            let series = resources["series"] as? String,
            let year = resources["year"] as? Int,
            let pages = resources["pages"] as? Int,
            let price = resources["price"] as? Double,
            let discount = resources["discount"] as? Double,
            let imagePath = resources["image_url"] as? String else {
                return nil
        }
        
        self.ISBN = ISBN
        self.title = title
        self.editor = editor
        self.series = series
        self.year = year
        self.pages = pages
        self.price = price
        self.discount = discount
        self.imageURL = URL(string: imagePath)
    }
    
    var discountedPrice: Double {
     
        guard self.discount < 1, self.discount > 0 else {
            return self.price
        }
        
        return self.price * (1 - self.discount)
    }
}

extension Book: Equatable {
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.ISBN == rhs.ISBN
    }
    
    
}

extenion Book: Hashable {
    
}
