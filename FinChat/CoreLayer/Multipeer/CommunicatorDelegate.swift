//
//  CommunicatorDelegate.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 10/04/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    // discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    // errors
    func failedToStartBrowsingForUsers(error: Error)
    func failtedToStartAdvertising(error: Error)
    
    // messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}
