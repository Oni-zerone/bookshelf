//
//  AuthorSorter.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

class AuthorSorter {
    
    enum SortParameter: Int {
        
        case name
        case age
        case id
        case nickname
        
        static let list = ["Nome", "Età", "Id", "Nickname"]
    }
    
    static func sortedAuthors(_ authors:Set<Author>, for parameter: SortParameter) -> Array<Author> {
        
        return authors.sorted(by: { (first, second) -> Bool in
            
            switch parameter {
             
            case .name:
                return (first.name + " " + first.surname) < (second.name + " " + second.surname)
            
            case .age:
                return first.birthDate.timeIntervalSinceNow > second.birthDate.timeIntervalSinceNow
                
            case .id:
                return first.id < second.id
                
            case .nickname:
                return first.nickname < second.nickname
            }
        })
    }
    
}
