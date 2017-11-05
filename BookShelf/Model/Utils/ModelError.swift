//
//  ModelError.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

extension NSError {
    
    static internal func invalidPath(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid path"])
    }
    
    static internal func invalidContent(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid content"])
    }
    
    static internal func invalidResponse(_ domain:String) -> NSError {
        
        return NSError(domain: domain,
                       code: 500,
                       userInfo: [NSLocalizedDescriptionKey : "invalid response"])
    }
}
