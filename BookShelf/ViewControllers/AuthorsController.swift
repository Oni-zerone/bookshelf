//
//  ViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class AuthorsController: UIViewController {

    struct Segue {
        static let books = "Books"
    }
    
    @IBOutlet weak var waitingContainer: UIView!
    @IBOutlet weak var waitingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var orderSelector: SwitchControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: AuthorsDataSource?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupDataSource()
        
        self.orderSelector.addTarget(self, action: #selector(didUpdateSort(sender:)), for: .valueChanged)
        self.didUpdateSort(sender: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedRow = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    private func setupUI() {
        
        self.waitingContainer.layer.cornerRadius = 10
        self.waitingContainer.clipsToBounds = true
        
        self.orderSelector.statuses = AuthorSorter.SortParameter.list
    }
    
    private func setupDataSource() {

        let cellIdentifier = "DetailTableViewCell"
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.dataSource = AuthorsDataSource(with: cellIdentifier, tableView: self.tableView)
    }
    
    @objc private func didUpdateSort(sender: Any?) {
        
        self.waitingContents = true
        
        guard let parameter = AuthorSorter.SortParameter(rawValue: self.orderSelector.selectedStatus) else {
            return
        }
        
        Model.shared.getAuthors { (authors, error) in
            self.waitingContents = false
            guard let authors = authors else {
                return
            }
            
            let sortedAuthors = AuthorSorter.sortedAuthors(authors, for: parameter)
            self.dataSource?.items = sortedAuthors
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == Segue.books,
            let indexPath = sender as? IndexPath else {
            return
        }
        
        guard let viewController = segue.destination as? BooksViewController,
            let author = self.dataSource?.items[indexPath.item] else {
                return
        }
        
        viewController.author = author
    }
}

extension AuthorsController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: Segue.books, sender: indexPath)
    }
    
}

