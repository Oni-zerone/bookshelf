//
//  AuthorTableViewCell.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

extension DetailTableViewCell: AuthorCell {
    
    func setAuthor(name: String) {
        self.firstLabel.text = name
    }
    
    func setAuthor(age: Date) {
        let age = Calendar.current.dateComponents([Calendar.Component.year], from: age, to: Date())
        guard let year = age.year else {
            self.thirdLabel.text = ""
            return
        }
        self.thirdLabel.text = "Età: \(year)"
    }
    
    func setAuthor(nickname: String) {
        self.secondLabel.text = "Nick: \(nickname)"
    }
    
    func setAuthor(id: Int) {
        self.fourthLabel.text = "ID: \(id)"
    }
}
