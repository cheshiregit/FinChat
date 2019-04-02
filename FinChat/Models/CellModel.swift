//
//  SellModel.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 25/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration: class {
    
    var userID : String? {get set}
    var name : String? {get set}
    var message : [MessageModel] {get set}
    var date : Date? {get set}
    var online : Bool {get set}
    var hasUnreadMessages : Bool {get set}
    
}

class CellModel: ConversationCellConfiguration {
    
    var userID : String?
    var name: String?
    var message: [MessageModel]
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
    
    init(userID: String, name: String, message: [MessageModel], date: Date, online: Bool, hasUnreadMessages: Bool) {
        self.userID = userID
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
}
