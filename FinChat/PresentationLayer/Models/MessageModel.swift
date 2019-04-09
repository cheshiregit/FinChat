//
//  MessageModel.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 19/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

struct MessageModel {
    var text: String?
    var isIncoming: Bool

    init(text: String?, isIncoming: Bool) {
        self.text = text
        self.isIncoming = isIncoming
    }
}
