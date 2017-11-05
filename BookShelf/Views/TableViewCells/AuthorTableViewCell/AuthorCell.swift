//
//  AuthorCell.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

protocol AuthorCell {
    
    func setAuthor(name: String)
    func setAuthor(age: Date)
    func setAuthor(nickname: String)
    func setAuthor(id: Int)
}
