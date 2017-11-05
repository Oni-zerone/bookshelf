//
//  BooksDataSource.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class BooksDataSouce: BaseDataSource<Book> {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let book = items[indexPath.row]
        if let bookCell = cell as? BookCell {
            
            bookCell.setBook(title: book.title)
            bookCell.setBook(discountedPrice: book.discountedPrice)
            bookCell.setBook(year: book.year)
            bookCell.setBook(pages: book.pages)
            bookCell.setBook(discount: book.discount)
        }
        return cell
    }
    
}
