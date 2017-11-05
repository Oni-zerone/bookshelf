//
//  BooksViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    var author: Author? {
        didSet {
            guard let author = self.author else {
                return
            }
            
            self.title = author.name + " " + author.surname
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
