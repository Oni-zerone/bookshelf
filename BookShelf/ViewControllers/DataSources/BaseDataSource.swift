//
//  BaseDataSource.swift
//  Nennos_Pizza
//
//  Created by Andrea Altea on 26/03/17.
//  Copyright © 2017 StudiOUT. All rights reserved.
//

import UIKit

class BaseDataSource<Item>: NSObject, UITableViewDataSource {

    //Model
    fileprivate var itemsStore: Array<Item> = []
    
    var items: Array<Item> {
        
        set {
            self.itemsStore = newValue
            self.tableView?.reloadData()
        }
        
        get {
            return self.itemsStore
        }
    }
    
    let cellIdentifier: String
    
    //View
    fileprivate weak var tableView: UITableView?
    
    required init(with identifier: String, tableView: UITableView) {
        
        self.cellIdentifier = identifier
        self.tableView = tableView
        
        super.init()
        tableView.dataSource = self
    }
    
    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    }
}

extension BaseDataSource where Item: Equatable {
    
    func update(with contents: Array<Item>) {

        DispatchQueue(label: "Bookshelf.DataSource.Update.Queue", qos: DispatchQoS.userInitiated).async {
            
            let removedIndexes = self.items.indexes(for: self.removedItems(with: contents))
            let addedIndexes = contents.indexes(for: self.addedItems(with: contents))

            DispatchQueue.main.sync {
                guard let tableView = self.tableView else {
                    return
                }
                
                tableView.beginUpdates()
                
                if let removed = removedIndexes  {
                    tableView.deleteRows(at: removed, with: .middle)
                }
                
                if let added = addedIndexes {
                    tableView.insertRows(at: added, with: .middle)
                }

                self.itemsStore = contents
                tableView.endUpdates()
            }
        }
    }
    
    private func removedItems(with contents: Array<Item>) -> Array<Item> {

        return self.items.filter { (item) -> Bool in
            return contents.index(of: item) == nil
        }
    }
    
    private func addedItems(with contents: Array<Item>) -> Array<Item> {
        
        return contents.filter({ (content) -> Bool in
            return self.items.index(of: content) == nil
        })
    }
}

fileprivate extension Array where Element: Equatable {
    
    func index(of element: Element) -> Int? {

        return self.index(where: { (item) -> Bool in
            return element == item
        })
    }
    
    func indexes(for items: Array<Element>) -> Array<IndexPath>? {
        
        guard items.count > 0 else {
            return nil
        }
        
        return items.flatMap({ (item) -> IndexPath? in
            
            guard let row = self.index(of: item) else {
                return nil
            }
            
            return IndexPath(row: row, section: 0)
        })
    }
}
