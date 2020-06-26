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
                .environment(\.persistentContainer, persistentContainer)
        }
    }
    
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

fileprivate struct PersistentContainerKey: EnvironmentKey {
    static let defaultValue: NSPersistentContainer = NSPersistentContainer(name: "")
}

extension EnvironmentValues {
    var persistentContainer: NSPersistentContainer {
        get { self[PersistentContainerKey.self] }
        set { self[PersistentContainerKey.self] = newValue }
    }
}
