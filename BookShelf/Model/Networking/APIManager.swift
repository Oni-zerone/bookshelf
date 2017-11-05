//
//  APIManager.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

import Foundation

struct APIManager: RequestManager {
    
    static var config = RequestManagerConfiguration()
    static public let ErrorDomain = "BOOKSHELF_API_DOMAIN"
}
