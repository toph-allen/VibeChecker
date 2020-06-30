//
//  VibeCheckerApp.swift
//  Shared
//
//  Created by Toph Allen on 6/25/20.
//

import SwiftUI

@main
struct VibeCheckerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .environment(\.taskContext, {
                    let taskContext = persistentContainer.newBackgroundContext()
                    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                    taskContext.undoManager = nil
                    return taskContext
                }())
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
        print("About to make a new persistent container!")
        let container = NSPersistentContainer(name: "VibeChecker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        try! container.viewContext.setQueryGenerationFrom(NSQueryGenerationToken.current)
        print("Made a new persistent container!")
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

private struct taskContextKey: EnvironmentKey {
    static let defaultValue: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
}

extension EnvironmentValues {
    var taskContext: NSManagedObjectContext {
        get { self[taskContextKey.self] }
        set { self[taskContextKey.self] = newValue }
    }
}
