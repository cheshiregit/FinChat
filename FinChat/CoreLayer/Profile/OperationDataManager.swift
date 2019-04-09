//
//  OperationDataManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 12/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

class OperationDataManager: DataManager {
    func saveData(profile: Profile, response: @escaping (SuccessStatus) -> Void) {
        let queue = OperationQueue()
        queue.name = "com.finchat.saveOperation"

        queue.addOperation({
            let status = UserFileManager.saveFile(profile: profile)
            print("Save Operation")
            response(status)
        })
    }

    func readData(response: @escaping ((Profile, SuccessStatus)) -> Void) {
        let queue = OperationQueue()
        queue.name = "com.finchat.readOperation"

        queue.addOperation({
            let status: (Profile, SuccessStatus) = UserFileManager.readFile()
            print("Read Operation")
            response(status)
        })
    }
}
