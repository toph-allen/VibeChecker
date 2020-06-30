//
//  CoreData.swift
//  VibeChecker
//
//  Created by Toph Allen on 6/30/20.
//

import Foundation
import CoreData
import Combine


class VibeProvider: ObservableObject {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VibeChecker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        try! container.viewContext.setQueryGenerationFrom(NSQueryGenerationToken.current)
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

