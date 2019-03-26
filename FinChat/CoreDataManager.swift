//
//  CoreDataManager.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 26/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    public static var shared = CoreDataManager()
    
    private var stack: CoreDataStack
    
    init() {
        stack = CoreDataStack()
    }
    
    public func saveUserProfileState(profile: Profile, completion: (() ->())?, in context: NSManagedObjectContext? = nil) {
        let context = context ?? self.stack.saveContext
        let user = AppUser.findOrInsertAppUser(in: context)
        self.stack.saveContext.perform {
            user?.userName = profile.userName
            user?.aboutUser = profile.aboutUser
            user?.userImage = profile.userImage?.pngData()
            user?.timestamp = Date()
            self.stack.performSave(with: context, completion: completion)
        }
        
    }
    
    public func getUserProfileState(from context: NSManagedObjectContext? = nil) -> Profile {
        let context = context ?? self.stack.mainContext
        let user = AppUser.findOrInsertAppUser(in: context)
        self.stack.performSave(with: context, completion: nil)
        
        
        
        return Profile(userName: user?.userName, aboutUser: user?.aboutUser, userImage: UIImage(data: user?.userImage ?? #imageLiteral(resourceName: "placeholder-user").pngData()!))
    }
}
