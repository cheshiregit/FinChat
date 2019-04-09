//
//  GCDDataManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 12/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

class GCDDataManager: DataManager {
    func saveData(profile: Profile, response: @escaping (SuccessStatus) -> Void) {
        let globalQueue = DispatchQueue.global(qos: .utility)
        globalQueue.async {
            print("save GCD")
            let status = UserFileManager.saveFile(profile: profile)
            response(status)
        }
    }

    func readData(response: @escaping ((Profile, SuccessStatus)) -> Void) {
        let globalQueue = DispatchQueue.global(qos: .utility)
        globalQueue.async {
            print("read GCD")
            let status: (Profile, SuccessStatus) = UserFileManager.readFile()
            response(status)
        }
    }
}
