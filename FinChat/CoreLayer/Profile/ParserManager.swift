//
//  ParserManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 17/04/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol ParserManagerProtocol: class {
    func parsePhotoList(data: Data) -> [String]?
}

class ParserManager: ParserManagerProtocol {
    func parsePhotoList(data: Data) -> [String]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            print("No json in came list")
            return nil
        }
        
        guard let dictionary = json as? [String: Any?] else {
            print("JSON is not a dictionary")
            return nil
        }
        
        guard let hits = dictionary["hits"] as? [[String: Any?]] else {
            print("Dictionary has no [hits]")
            return nil
        }
        
        var parsedData = [String]()
        for (index, dict) in hits.enumerated() {
            guard let link = dict["largeImageURL"] as? String else {
                print("no [largeImageURL] member in [hits][\(index)]")
                continue
            }
            parsedData.append(link)
        }
        return parsedData
    }
}
