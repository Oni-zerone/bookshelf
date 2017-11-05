//
//  BookCell.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

protocol BookCell {
    
    func setBook(title: String)
    func setBook(discountedPrice: Double)
    func setBook(year: Int)
    func setBook(pages: Int)
    func setBook(discount: Double)
}
