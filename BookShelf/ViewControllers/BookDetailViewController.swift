//
//  BookDetailViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    var book:Book? {
        
        didSet {
            if self.isViewLoaded {
                self.reloadContents()
            }
        }
    }
    
    var author:Author? {
        
        didSet {
            if self.isViewLoaded {
                self.reloadContents()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadContents()
    }
    
    @IBAction func dismissController(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func reloadContents() {
        
        guard let book = self.book,
            let author = self.author else {
            return
        }
        
        self.authorLabel.text = author.surname + " " + author.name
        self.titleLabel.text = book.title
        
        self.priceLabel.text = String(format: "%.2f €", book.discountedPrice)
        self.infoLabel.text = String(format: "Prezzo di copertina %.2f risparmio %.0f%", book.price, book.discount * 100)
        
        self.pagesLabel.text = "\(book.pages)"
        self.yearLabel.text = "\(book.year)"
        self.publisherLabel.text = book.publisher
        self.seriesLabel.text = book.series
    }
}