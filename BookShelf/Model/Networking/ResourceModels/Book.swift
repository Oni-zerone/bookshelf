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
    let publisher: String
    let series: String
    let year: Int
    let pages: Int
    let price: Double
    let discount: Double
    let imageURL: URL?
    
    init?(resource: Dictionary<String, Any>) {
        
        guard let ISBN = resource["ISBN"] as? Int,
            let title = resource["title"] as? String,
            let publisher = resource["publisher"] as? String,
            let series = resource["series"] as? String,
            let year = resource["year"] as? Int,
            let pages = resource["pages"] as? Int,
            let price = resource["price"] as? Double,
            let discount = resource["discount"] as? Double,
            let imagePath = resource["image_URL"] as? String else {
                return nil
        }
        
        self.ISBN = ISBN
        self.title = title
        self.publisher = publisher
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

extension Book: Hashable {
    
    var hashValue: Int {
        return self.ISBN
    }
}
