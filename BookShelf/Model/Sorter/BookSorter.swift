//
//  BookSorter.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

class BookSorter {
    
    enum SortParameter: Int {
        
        case title
        case year
        case pages
        case price
        case discount
        
        static let list = ["Titolo", "Anno", "Pagine", "Prezzo", "Discount"]
    }
    
    static func sortedBooks(_ books:Set<Book>, for parameter: SortParameter) -> Array<Book> {
     
        return books.sorted(by: { (first, second) -> Bool in
            
            switch parameter {
             
            case .title:
                return first.title < second.title
                
            case .year:
                return first.year < second.year
                
            case .pages:
                return first.pages < second.pages
                
            case .price:
                return first.discountedPrice < second.discountedPrice
                
            case .discount:
                return first.discount < second.discount
            }
        })
    }
}
