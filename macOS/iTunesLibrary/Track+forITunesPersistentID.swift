//
//  Track.swift
//  VibeChecker
//
//  Created by Toph Allen on 3/27/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation
import CoreData
import iTunesLibrary


extension Track {
    /// Returns the track for a given iTunes object.
    class func forITunesPersistentID(_ persistentID: String, in moc: NSManagedObjectContext) throws -> Track? {
        let request: NSFetchRequest<NSFetchRequestResult> = fetchRequest()
        request.predicate = NSPredicate(format: "iTunesPersistentID == %@", persistentID)
        
        do {
            let results = try moc.fetch(request) as! [Track]
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
    
    class func forITunesMediaItem(_ mediaItem: ITLibMediaItem, in moc: NSManagedObjectContext) throws -> Track? {
        return try forITunesPersistentID(mediaItem.persistentID.uint64String, in: moc)
    }
}

