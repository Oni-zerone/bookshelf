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
    
}
