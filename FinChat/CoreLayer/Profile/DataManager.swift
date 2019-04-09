//
//  DataManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 13/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

protocol DataManager {
    func saveData(profile: Profile, response: @escaping (SuccessStatus) -> Void)
    func readData(response: @escaping ((Profile, SuccessStatus)) -> Void)
}
