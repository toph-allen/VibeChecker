//
//  ImportView.swift
//  VibeChecker
//
//  Created by Toph Allen on 6/30/20.
//

import SwiftUI
import CoreData

enum ImportViewState {
    case ready, importing
}


struct ImportView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var importViewState = ImportViewState.ready
    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: nil) var containers: FetchedResults<Container>
    @FetchRequest(entity: Track.entity(), sortDescriptors: [], predicate: nil) var tracks: FetchedResults<Track>

    
    var body: some View {
        VStack(alignment: .leading) {
            switch importViewState {
            case .ready:
                VStack {
                    Text("VibeChecker Library").font(.headline)
                    Text("Containers: \(containers.count)")
                    Text("Tracks: \(tracks.count)")
                }
            case .importing:
                Text("Importing…")
            }
            HStack {
                Button("Done", action: { presentationMode.wrappedValue.dismiss() })
                Button("Import", action: {
//                    let taskContext = persistentContainer.newBackgroundContext()
//                    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                    let importer = ITunesImporter(for: moc)
                    importer.importITunesLibrary()
                })

            }
        }
        .padding(.all)
    }
}


//struct LibraryStatisticsView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: nil) var containers: FetchedResults<Container>
//    @FetchRequest(entity: Track.entity(), sortDescriptors: [], predicate: nil) var tracks: FetchedResults<Track>
//
//    var body: some View {
//        VStack {
//            Text("VibeChecker Library").font(.headline)
//            Text("Containers: \(containers.count)")
//            Text("Tracks: \(tracks.count)")
//        }
//    }
//}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
    
        
        
        return Group {
//            ImportView()
        }
    }
}
