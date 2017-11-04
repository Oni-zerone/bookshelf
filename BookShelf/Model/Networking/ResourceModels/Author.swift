//
//  Author.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

struct Author {
    
    let id: Int
    let name: String
    let surname: String
    let nickname: String
    let birthDate: Date
    
    init?(resource:Dictionary<String, Any>) {
        
        guard let id = resource["id"] as? Int,
            let name = resource["name"] as? String,
            let surname = resource["surname"] as? String,
            let nickname = resource["nickname"] as? String,
            let birthDate = resource["birthdate"] as? TimeInterval else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.surname = surname
        self.nickname = nickname
        self.birthDate = Date(timeIntervalSince1970: birthDate)
    }
    
}

extension Author: Equatable {
    
    static func ==(lhs: Author, rhs: Author) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Author: Hashable {
    var hashValue: Int {
        return id
    }
    
    
    
}
