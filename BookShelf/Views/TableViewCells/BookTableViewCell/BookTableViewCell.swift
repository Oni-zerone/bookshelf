//
//  BookTableViewCell.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

extension DetailTableViewCell: BookCell {

    func setBook(title: String) {
        self.firstLabel.text = title
    }

    
    func setBook(year: Int) {
        self.thirdLabel.text = "Anno: \(year)"
    }
    
    func setBook(discount: Double) {
        self.secondAccessorLabel.text = "\(Int(discount * 100))%"
    }
    
    func setBook(pages: Int) {
        self.fourthLabel.text = "Pagine: \(pages)"
    }
    
    func setBook(discountedPrice: Double) {
        self.secondLabel.text = String(format: "%.2f €", discountedPrice)
    }
}
