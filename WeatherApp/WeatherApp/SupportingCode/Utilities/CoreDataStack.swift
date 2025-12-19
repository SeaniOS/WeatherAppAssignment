//
//  CoreDataStack.swift
//  WeatherApp
//
//  Created by DO HOANG SON on 19/12/25.
//

import Foundation
import CoreData

final class CoreDataStack {
    private init() {}
    static let shared = CoreDataStack()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherAppCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            myPrint("persistentContainer.loadPersistentStores with error: \(String(describing: error?.localizedDescription))")
        })
        return container
    }()
    
    lazy var testContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherAppCoreData")
        
        // InMemory
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // prevent race condition
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            myPrint("testContainer.loadPersistentStores with error: \(String(describing: error?.localizedDescription))")
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // prevent crash or conflict
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}

/*
// MARK: - Core Data Saving support
extension CoreDataStack {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
*/
