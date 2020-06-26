//
//  Container+Extensions.swift
//  VibeChecker-macOS
//
//  Created by Toph Allen on 6/1/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation
import CoreData
import iTunesLibrary


enum FetchError: Error {
    case moreThanOne(iTunesPersistentID: String)
}

extension Container {
    /// Returns the container for a given iTunes object.
    class func forITunesPersistentID<T: Container>(_ persistentID: String, in moc: NSManagedObjectContext) throws -> T? {
        let request: NSFetchRequest<NSFetchRequestResult> = fetchRequest()
        request.predicate = NSPredicate(format: "iTunesPersistentID == %@", persistentID)
        
        do {
            let results = try moc.fetch(request) as! [T]
            guard results.count == 1 else {
                if results.count > 1 {
                    throw FetchError.moreThanOne(iTunesPersistentID: persistentID)
                } else { // results.count == 0
                    return nil
                }
            }
            return results.first
        }
    }
    
    class func forITunesPlaylist<T: Container>(_ playlist: ITLibPlaylist, in moc: NSManagedObjectContext) throws -> T? {
        return try forITunesPersistentID(playlist.persistentID.uint64String, in: moc)
    }
}


