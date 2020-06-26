////
////  ITunesImporter.swift
////  VibeChecker-macOS
////
////  Created by Toph Allen on 6/8/20.
////  Copyright © 2020 Toph Allen. All rights reserved.
////
//
//import Cocoa
//import Foundation
//import iTunesLibrary
//import CoreData
//
//
//enum ImportError: Error {
//    case moreThanOne(iTunesPersistentID: String)
//}
//
//enum ContainerCreationError: Error {
//    case mismatchedPlaylistKind
//    case calledOnAbstractParent
//}
//
//
//class ITunesImporter {
//    var library = ITLibraryInterface()
//    var moc: NSManagedObjectContext
//    
//    init(for moc: NSManagedObjectContext) {
//        self.moc = moc
//    }
//    
//    func createContainerSubclass(from source: ITLibPlaylist) -> Container? {
//        print("Creating container for: \(source.name)")
//        var newContainer: Container?
//        switch source.kind {
//        case .genius, .geniusMix, .smart:
//            print("Skipping container creation for \(source.name)")
//            return nil
//        case .folder:
//            print("This is a folder.")
//            newContainer = createFolder(from: source)
//        case .regular:
//            if library.vibeFolderInAncestors(of: source) {
//                print("This is a vibe.")
//                newContainer = createVibe(from: source)
//            } else {
//                print("This is a playlist.")
//                newContainer = createPlaylist(from: source)
//                print("Returned from createPlaylist")
//            }
//        default:
//            fatalError("Unknown ITLibPlaylistKind type.")
//        }
//        
//        guard newContainer != nil else {
//            print("Failed to create container for \(source.name)")
//            return nil
//        }
//        
//        // Getting an item's Folder here so we can look up with libraryInterface
//        var parent: Folder?
//        if let sourceParent = library.parentPlaylist(of: source) {
//            print("This playlist has a parent.")
//            parent = createContainerSubclass(from: sourceParent) as! Folder?
//            print("Parent's name is \(String(describing: parent?.name)).")
//            newContainer!.parent = parent
//        }
//        print("About to return from createContainerSubclass.")
//        return newContainer
//    }
//    
//    
//    // MARK: Container creation
//    
//    func createFolder(from source: ITLibPlaylist) -> Folder {
//        print("in createFolder()")
//        let folder = NSEntityDescription.insertNewObject(forEntityName: "Folder", into: moc) as! Folder
//        
////        guard source.kind == .folder else {
////            throw ContainerCreationError.mismatchedPlaylistKind
////        }
//        
//        print(source.distinguishedKind.rawValue)
//        
//        folder.iTunesPersistentID = source.persistentID.stringValue
//        folder.name = source.name
//        folder.id = UUID.init()
//        
//        try! moc.save()
//        
//        return folder
//    }
//    
//    func createPlaylist(from source: ITLibPlaylist) -> Playlist {
//        print("in createPlaylist()")
//        let playlist = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: moc) as! Playlist
//        
////        guard source.kind == .regular else {
////            throw ContainerCreationError.mismatchedPlaylistKind
////        }
//        
//        print(source.distinguishedKind.rawValue)
//        
//        playlist.iTunesPersistentID = source.persistentID.stringValue
//        playlist.name = source.name
//        playlist.id = UUID.init()
//        
//        var order: Int64 = 0
//        for sourceTrack in source.items {
//            print("Adding a track for \(String(describing: playlist.name)).")
//            let track = createTrack(from: sourceTrack)
//            print("Adding PlaylistTrack entity for \(String(describing: playlist.name)).")
//            let playlistTrack = NSEntityDescription.insertNewObject(forEntityName: "PlaylistTrack", into: moc) as! PlaylistTrack
//            print("Done.")
//            playlistTrack.playlist = playlist
//            playlistTrack.track = track
//            playlistTrack.order = order
//
//            order += 1
//        }
//        try! moc.save()
////        print("About to return the playlist.")
//        return playlist
//    }
//    
//    func createVibe(from source: ITLibPlaylist) -> Vibe {
////        print("in createVibe()")
//        let vibe = NSEntityDescription.insertNewObject(forEntityName: "Vibe", into: moc) as! Vibe
//        
////        guard source.kind == .regular else {
////            throw ContainerCreationError.mismatchedPlaylistKind
////        }
//        
//        print("Creating playlist from \(source.name)")
//        print(source.distinguishedKind.rawValue)
//        
//        vibe.iTunesPersistentID = source.persistentID.stringValue
//        vibe.name = source.name
//        vibe.id = UUID.init()
//        
//        // Get tracks for vibe
//        
//        for sourceTrack in source.items {
//            print("Adding vibe relationship for \(String(describing: vibe.name))")
//            let track = createTrack(from: sourceTrack)
//            vibe.addToTracks(track)
//        }
//        try! moc.save()
//        return vibe
//    }
//    
//    func createTrack(from source: ITLibMediaItem) -> Track {
//        let track = NSEntityDescription.insertNewObject(forEntityName: "Track", into: moc) as! Track
//        print("Creating track from \(source.title)")
//        track.addedDate = source.addedDate
//        track.artistName = source.artist?.name
//        track.albumTitle = source.album.title
//        track.title = source.title
//        track.beatsPerMinute = Int64(source.beatsPerMinute)
//        track.id = UUID.init()
//        track.iTunesPersistentID = source.persistentID.uint64String
//        if source.locationType == ITLibMediaItemLocationType.file {
//            track.location = source.location
//        }
//        track.title = source.title
//        track.trackNumber = Int64(source.trackNumber)
//        try! moc.save()
//        return track
//    }
//    
//    
//    func importITunesPlaylists() {
//        print("About to import playlists!")
//        for playlist in library.allPlaylists {
//            _ = createContainerSubclass(from: playlist)
//        }
//        print("About to try moc.save()")
//        try! moc.save()
//        print("It finished.")
//    }
//    
//    
//    func importITunesTracks() {
//        print("About to import tracks!")
//        for track in library.allTracks {
//            _ = createTrack(from: track)
//        }
//        try! moc.save()
//    }
//    
//    
//    func importInBatches<T: RandomAccessCollection>(_ source: T, method: (T.Element) -> Any) where T.Index == Int {
//        let batchSize = 256
//        
//        let count = source.count
//        
//        var numBatches = count / batchSize
//        numBatches += count % batchSize > 0 ? 1 : 0
//        
//        for batchNumber in 0 ..< numBatches {
//            // Determine the range for this batch
//            let batchStart = batchNumber * batchSize
//            let batchEnd = batchStart + min(batchSize, count - batchNumber * batchSize)
//            let range = batchStart..<batchEnd
//            
//            print("About to try batch \(batchNumber) of \(numBatches).")
//            importOneBatch(source[range], method: method)
//        }
//    }
//    
//    func importOneBatch<T: RandomAccessCollection>(_ source: T, method: (_ from: T.Element) -> Any) {
//        for element in source {
//            print("Creating item in batch.")
//            _ = method(element)
//            print("Done creating item.")
//        }
//        print("saving from batch import")
//        do {
//            try moc.save()
//        } catch {
//            print("Encountered error: \(error)")
//        }
//        print("Finished batch.")
//    }
//    
//    
//    func importITunesLibraryInBatches() -> Void {
//        print("About to import tracks in batches.")
//        importInBatches(library.allTracks, method: createTrack)
//        print("About to import playlists in batches.")
//        importInBatches(library.allPlaylists, method: createContainerSubclass)
//    }
//    
//    
//    func importITunesLibrary() -> Void {
//        print("About to import library!")
//        importITunesTracks()
//        importITunesPlaylists()
//        try! moc.save()
//    }
//}
