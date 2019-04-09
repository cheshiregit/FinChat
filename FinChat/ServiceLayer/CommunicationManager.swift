//
//  CommunicationManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 19/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol CommunicationManagerDelegate: class {

    func didUpdateDialogList(dialogs: [CellModel])
    func didReceiveMessageInDialogList(text: String, fromUser: String)
}

class CommunicationManager: NSObject, CommunicatorDelegate {

    var communicator: MultipeerCommunicator?
    var dialogs = [CellModel]()
    weak var delegate: CommunicationManagerDelegate?
    weak var conversationDelegate: ConversationDelegate?
    weak var changeUserState: ChangeUserState?

    override init() {
        super.init()
        communicator = MultipeerCommunicator()
        self.communicator?.delegate = self
    }

    func didFoundUser(userID: String, userName: String?) {
        print("didFoundUser: userID: \(userID), userName: \(String(describing: userName))")
        if let dialog = dialogs.first(where: {$0.userID == userID}) {
            dialog.online = true
        } else {
            let newDialog = CellModel(userID: userID, name: userName ?? "no name", message: [], date: Date(), online: true, hasUnreadMessages: false)
            dialogs.append(newDialog)
        }
        delegate?.didUpdateDialogList(dialogs: dialogs)
        changeUserState?.userOnline(userId: userID)
    }

    func didLostUser(userID: String) {
        if let dialog = dialogs.first(where: {$0.userID == userID}) {
            dialog.online = false
        }
        delegate?.didUpdateDialogList(dialogs: dialogs)
        changeUserState?.userOffline(userId: userID)
    }

    func failedToStartBrowsingForUsers(error: Error) {
        print("failedToStartBrowsingForUsers \(error)")
    }

    func failtedToStartAdvertising(error: Error) {
        print("failtedToStartAdvertising \(error)")
    }

    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        self.conversationDelegate?.didReceiveMessage(text: text, fromUser: fromUser)
        self.delegate?.didReceiveMessageInDialogList(text: text, fromUser: fromUser)
    }

}
