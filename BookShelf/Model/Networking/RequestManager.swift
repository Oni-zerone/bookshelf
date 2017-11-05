//
//  RequestManager.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import Foundation

struct RequestManagerConfiguration {
    
    let scheme: String!
    let host: String!
    let basePath: String!
    
    let session: URLSession
    
    init(scheme: String = "", host: String = "", basePath: String = "", session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.scheme = scheme
        self.host = host
        self.basePath = basePath
        
        self.session = session
    }
}

protocol RequestManager {
    
    static var config:RequestManagerConfiguration { get set }
    static var ErrorDomain: String { get }

    static func URLForResource(resourcePath: String, with parameters:[String: String]) -> URL?
    
    static func responseDictionaryCheck(_ completion:@escaping (Dictionary<String, Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void
    static func responseArrayCheck(_ completion:@escaping (Array<Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void
    
}

extension RequestManager {
    
    static func URLForResource(resourcePath: String, with parameters:[String: String] = [:]) -> URL? {
        
        var parametersString = ""
        
        parameters.forEach { (key, value) in
            
            parametersString += parametersString.characters.count < 1 ? "?" : "&"
            parametersString += "\(key)=\(value)"
        }
        
        let fullPath = "\(Self.config.scheme!)://\(Self.config.host!)/\(Self.config.basePath!)/\(resourcePath)\(parametersString)"
        return URL(string:fullPath)
    }
    
    static internal func responseDictionaryCheck(_ completion:@escaping (Dictionary<String, Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        
        return { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
            
            guard let data = responseData, error == nil else {
                
                return completion(nil, error)
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let dictionary = jsonObject as? Dictionary<String, Any> else {
                    return completion(nil, NSError.invalidResponse(ErrorDomain))
                }
                
                return completion(dictionary, nil)
                
            } catch let jsonError {
                
                return completion(nil, jsonError)
            }
        }
    }
    
    static internal func responseArrayCheck(_ completion:@escaping (Array<Any>?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        
        return { (_ responseData: Data?, _ response: URLResponse?, _ error: Error?) in
            
            guard let data = responseData, error == nil else {
                
                return completion(nil, error)
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let array = jsonObject as? Array<Any> else {
                    return completion(nil, NSError.invalidResponse(ErrorDomain))
                }
                
                return completion(array, nil)
                
            } catch let jsonError {
                
                return completion(nil, jsonError)
            }
        }
    }
}
