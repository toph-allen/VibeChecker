//
//  VibeEditView.swift
//  iOS
//
//  Created by Toph Allen on 7/5/20.
//

import SwiftUI

struct VibeEditView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var track: Track
//    @FetchRequest var trackVibes: FetchedResults<Vibe>
//    @State var trackVibes: Set<Vibe>
    @FetchRequest(entity: Container.entity(), sortDescriptors: [], predicate: NSPredicate(format: "parent == nil")) var rootContainers: FetchedResults<Container>
    
//    init(track: Track) {
//        self.track = track
//        let predicate = NSPredicate(format: "track = %@", track)
//        self._trackVibes = FetchRequest(
//            entity: Vibe.entity(),
//            sortDescriptors: [],
//            predicate: predicate
//        )
//    }
    
    var body: some View {
        List {
            OutlineGroup(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? [], children: \.childArray) { item in
//            ForEach(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? []) { item in
                
                
                switch item {
                case let vibe as Vibe:
                    VibeEditRow(track: track, vibe: vibe)
                case let folder as Folder:
                    Text(folder.name ?? "")
                default:
                    EmptyView()
                }
            }
        }
//        .listStyle(SidebarListStyle())
    }
}


struct VibeEditRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var track: Track
    @ObservedObject var vibe: Vibe

    @ViewBuilder
    var body: some View {
        if (vibe.tracks?.contains(track)) ?? false {
            Text(vibe.name ?? "")
                .background(Color.accentColor)
                .foregroundColor(.white)
                .onTapGesture {
                    vibe.removeFromTracks(track)
                    try! moc.save()
                }
        } else {
            Text(vibe.name ?? "")
                .onTapGesture {
                    try! moc.save()
                }
        }
        
    }
}

//struct VibeEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        VibeEditView()
//    }
//}
