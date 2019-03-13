//
//  ProfileModel.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 12/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation

struct Profile: ProfileProtocol {
    var userName: String?
    var aboutUser: String?
    var userImage: UIImage?
    
    init() {
        
    }
    
    init(userName: String?, aboutUser: String?, userImage: UIImage?) {
        self.userName = userName
        self.aboutUser = aboutUser
        self.userImage = userImage
    } 
}

protocol ProfileProtocol {
    var userName: String? { get set }
    var aboutUser: String? { get set }
    var userImage: UIImage? { get set }
}

