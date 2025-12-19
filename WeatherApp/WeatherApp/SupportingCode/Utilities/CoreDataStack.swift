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
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
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
