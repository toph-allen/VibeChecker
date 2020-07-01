//
//  EnvironmentKeys.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import Foundation
import SwiftUI


private struct taskContextKey: EnvironmentKey {
    static let defaultValue: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
}


extension EnvironmentValues {
    var taskContext: NSManagedObjectContext {
        get { self[taskContextKey.self] }
        set { self[taskContextKey.self] = newValue }
    }
}
