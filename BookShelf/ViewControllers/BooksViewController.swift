//
//  BooksViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    struct Segue {
        static let bookDetail = "BookDetail"
    }
    
    @IBOutlet weak var waitingContainer: UIView!
    @IBOutlet weak var waitingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var orderSelector: SwitchControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: BooksDataSouce?
    
    var waitingContents:Bool = true {
        
        didSet {
            switch self.waitingContents {
                
            case true:
                self.waitingIndicator.startAnimating()
                self.waitingContainer.isHidden = false
                self.tableView.isHidden = true
                break
                
            case false:
                self.waitingIndicator.stopAnimating()
                self.waitingContainer.isHidden = true
                self.tableView.isHidden = false
                break
            }
        }
    }
    
    var author: Author? {
        didSet {
            guard let author = self.author else {
                return
            }
            
            self.title = author.name + " " + author.surname
            if self.isViewLoaded {
                self.didUpdateSort(sender: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupDataSource()
        
        self.didUpdateSort(sender: nil)
    }
    
    func setupUI() {
        
        self.waitingContainer.layer.cornerRadius = 10
        self.waitingContainer.clipsToBounds = true
        
        self.orderSelector.statuses = BookSorter.SortParameter.list

    }
    
    func setupDataSource() {
        
        let cellIdentifier = "DetailTableViewCell"
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.dataSource =  BooksDataSouce(with: cellIdentifier, tableView: self.tableView)
    }
    
    @objc private func didUpdateSort(sender: Any?) {
        
        self.waitingContents = true
        
        guard let parameter = BookSorter.SortParameter(rawValue: self.orderSelector.selectedStatus),
            let author = self.author else {
            return
        }
        
        Model.shared.getBooks(for: author) { (books, error) in
            self.waitingContents = false
            guard let books = books else {
                return
            }
            
            let sortedBooks = BookSorter.sortedBooks(books, for: parameter)
            self.dataSource?.items = sortedBooks
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Segue.bookDetail,
            let indexPath = sender as? IndexPath,
            let bookDetailController = segue.destination as? BookDetailViewController else {
            return
        }
        
        bookDetailController.author = self.author
        bookDetailController.book = self.dataSource?.items[indexPath.item]
    }
}

extension BooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Segue.bookDetail, sender: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
