//
//  DatabaseManager.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-26.
//

import Foundation
import CoreData

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "iosDevLab")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

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
 

    

