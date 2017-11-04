//
//  ViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class AuthorsController: UIViewController {

    @IBOutlet weak var waitingContainer: UIView!
    @IBOutlet weak var waitingIndicator: UIActivityIndicatorView!
    
    var waitingContents:Bool = true {
        
        didSet {
            switch self.waitingContents {
                
            case true:
                self.waitingIndicator.startAnimating()
                self.waitingContainer.isHidden = false
                break
                
            case false:
                self.waitingIndicator.stopAnimating()
                self.waitingContainer.isHidden = true
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        Model.shared.getAuthors { (authors, error) in
            authors?.forEach({ (author) in
                
//                self.waitingContents = false
                print("\(author.name) \(author.surname)")
            })
        }
    }

    private func setupUI() {
        
        self.waitingContainer.layer.cornerRadius = 10
        self.waitingContainer.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

