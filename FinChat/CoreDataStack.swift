//
//  CoreDataStack.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 20/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    var storeUrl: URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsUrl.appendingPathComponent("MySecondStore.sqlite")
    }
    
    let dataModelName = "AppUserModel"
    let dataModelExtension = "momd"
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.dataModelName, withExtension: self.dataModelExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeUrl, options: nil)
        } catch {
            assert(false, "Error")
        }
        return coordinator
    }()
    
    
    lazy var masterContext: NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return masterContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
    }()
    
    lazy var saveContext: NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.mainContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        
        return saveContext
    }()
    
    typealias SaveCompletion = () -> Void
    func performSave(with context: NSManagedObjectContext, completion: SaveCompletion? = nil) {
        guard context.hasChanges else {
            completion?()
            return
        }
        
        context.perform {
            do {
                try context.save()
            } catch {
                print("Context error")
            }
            if let parentContext  = context.parent {
                self.performSave(with: parentContext, completion: completion)
            } else {
                completion?()
            }
        }
    }
    
}


extension AppUser {
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        var foundUser: AppUser? = nil
        
        context.performAndWait {
            do {
                
                let result = try context.fetch(fetchRequest)
                if let user = result.first {
                    foundUser = user
                }
            } catch {
                print("Error in fetching")
            }
            
            if foundUser == nil {
                foundUser = AppUser.insertAppUser(in: context)
            }
        }
        return foundUser
    }
    
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { return nil }
//        appUser.name = "name one"
//        appUser.timestamp = Date()
        return appUser
    }
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
            let templateName = "AppUser"
            guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
                assert(false, "No tempate")
                return nil
            }
            return fetchRequest
    }
}
