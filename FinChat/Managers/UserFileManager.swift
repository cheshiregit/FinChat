//
//  UserFileManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 13/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

class UserFileManager: NSObject {
    static let temporaryDirectory = FileManager.default.temporaryDirectory
    static let fileName = "UserProfile.txt"
    static let filePath = temporaryDirectory.appendingPathComponent(fileName)
    
    static func saveFile(profile: Profile) -> SuccessStatus {
        var dataDictionary: [String: String] = [:]
        print(filePath.path)
        if let userName = profile.userName {
            dataDictionary["userName"] = userName
        }
        if let aboutUser = profile.aboutUser {
            dataDictionary["aboutUser"] = aboutUser
        }
        if let userImage = profile.userImage {
            dataDictionary["userImage"] = userImage.pngData()?.base64EncodedString()
        }
        
        do {
            let jsonDataToSave = try JSONSerialization.data(withJSONObject: dataDictionary, options: .init(rawValue: 0))
            try jsonDataToSave.write(to: filePath, options: [])
            return SuccessStatus.Success
        } catch {
            print(error.localizedDescription)
            return SuccessStatus.Error
        }
    }
    
    static func readFile() -> (Profile, SuccessStatus) {
        do {
            let loadData = try Data(contentsOf: filePath)
            let jsonLoadData = try JSONSerialization.jsonObject(with: loadData, options: .mutableLeaves)
            if let userDictionary = jsonLoadData as? Dictionary<String, String> {
                var userProfile = Profile()
                userProfile.userName = userDictionary["userName"]
                userProfile.aboutUser = userDictionary["aboutUser"]
                if let data = Data(base64Encoded: (userDictionary["userImage"])!){
                    userProfile.userImage = UIImage(data: data)
                } else {
                    userProfile.userImage = UIImage(named: "placeholder-user")
                }
                return (userProfile, SuccessStatus.Success)
            } else {
                return (Profile(), SuccessStatus.Error)
            }
        } catch {
            return (Profile(), SuccessStatus.Error)
        }
    }
}

enum SuccessStatus {
    case Success
    case Error
}
