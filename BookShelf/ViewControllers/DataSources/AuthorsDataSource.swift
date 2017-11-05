//
//  AuthorsDataSource.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class AuthorsDataSource: BaseDataSource<Author> {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let author = items[indexPath.row]
        if let authorCell = cell as? AuthorCell {
         
            authorCell.setAuthor(id: author.id)
            authorCell.setAuthor(name: author.name + " " + author.surname)
            authorCell.setAuthor(nickname: author.nickname)
            authorCell.setAuthor(age: author.birthDate)
        }
        return cell
    }
}

