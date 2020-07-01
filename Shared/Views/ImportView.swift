//
//  ImportView.swift
//  VibeChecker
//
//  Created by Toph Allen on 6/30/20.
//

import SwiftUI
import CoreData


struct ImportView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.managedObjectContext) var taskContext
    @Environment(\.presentationMode) var presentationMode
    @StateObject var importer: ITunesImporter
    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: nil) var containers: FetchedResults<Container>
    @FetchRequest(entity: Track.entity(), sortDescriptors: [], predicate: nil) var tracks: FetchedResults<Track>
    

    var body: some View {
        VStack(alignment: .leading) {
            switch importer.state {
            case .ready:
                VStack {
                    LibraryStatisticsView(
                        containerCount: containers.count, trackCount: tracks.count
                    )
                }
            case .importing:
                Text("Importing…")
            }
            HStack {
                Button("Delete", action: {
                    let entityNames = ["Container", "Track", "PlaylistTrack", "Artist", "Album"]
                    for entityName in entityNames {
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                        do {
                            try moc.executeAndMergeChanges(using: batchDeleteRequest)
                        } catch {
                            fatalError("Failed to perform batch delete: \(error)")
                        }
                    }
                })
                Spacer()
                Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                Button("Import", action: {
                    taskContext.perform {
                        importer.importITunesLibrary()
                    }
                })
                Button("Toggle State", action: {
                    taskContext.perform {
                        importer.toggleState()
                    }
                })

            }
        }
        .padding(.all)
    }
}




struct LibraryStatisticsView: View {
    @State var containerCount: Int
    @State var trackCount: Int

    var body: some View {
        VStack {
            Text("VibeChecker Library").font(.headline)
            Text("Containers: \(containerCount)")
            Text("Tracks: \(trackCount)")
        }
    }
}


struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
    
        
        
        return Group {
//            ImportView()
        }
    }
}
