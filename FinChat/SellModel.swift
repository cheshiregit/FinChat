//
//  SellModel.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 25/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

struct CellModel {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUreadMessages: Bool
    
    init(name: String, message: String, date: Date, online: Bool, hasUnreadMessages: Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUreadMessages = hasUnreadMessages
    }
}
