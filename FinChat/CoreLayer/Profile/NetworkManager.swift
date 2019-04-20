//
//  NetworkManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 17/04/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol: class {
    
    func askDataList(completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void)
    func askImageData(forPath path: String, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void)
    
}

class NetworkManager: NetworkManagerProtocol {
    let session = URLSession.shared
    let apiKey = "12197176-035d139dfa636526ac033a644"
    var listUrl: URL?
    
    init() {
        let prefix = "https://pixabay.com/api/?key="
        let postfix = "&q=yellow+flowers&image_type=photo&pretty=true"
        let path = prefix + apiKey + postfix
        self.listUrl = URL(string: path)
    }
    
    func askDataList(completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let listURL = listUrl else {
            print("No list URL")
            return
        }
        
        dataTask(withURL: listURL, andCompletion: completionHandler)
    }
    
    func askImageData(forPath path: String, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let imageURL = URL(string: path) else {
            print("Not an image URL: " + path)
            return
        }
        
        dataTask(withURL: imageURL, andCompletion: completionHandler)
    }
    
    private func dataTask(withURL url: URL, andCompletion completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let task = session.dataTask(with: url) { (data: Data?, _ response: URLResponse?, error: Error?) in
            completionHandler(data, error)
        }
        task.resume()
    }
}
