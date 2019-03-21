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
        return documentsUrl.appendingPathComponent("MyStore.sqlite")
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
    
    /*
    lazy var masterContext: NSManagedObjectContext = {
        var masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return masterContext
    }()
    */
    
    lazy var mainContext: NSManagedObjectContext = {
        var mainContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
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
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available")
            assert(false)
            return nil
        }
        var appUser: AppUser?
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else {
            return nil
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
                print("Failed to fetch AppUser")
        }
        if appUser == nil {
            appUser = AppUser.issertAppUser(in: context)
        }
        
        return appUser
    }
}

extension AppUser {
    
    static func issertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { return nil }
        appUser.name = "name one"
        appUser.timestamp = Date()
        return appUser
    }
}

extension AppUser {
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
            let templateName = "AppUser"
            guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
                assert(false, "No tempate")
                return nil
            }
            return fetchRequest
    }
}
