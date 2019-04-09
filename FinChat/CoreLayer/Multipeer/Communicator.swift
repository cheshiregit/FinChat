//
//  Communicator.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 10/04/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol Communicator {
    
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?)
    var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}
