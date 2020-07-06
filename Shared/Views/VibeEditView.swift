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
    @State var filterString: String = ""
    
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
        // N.B. This might be better in a list if SwiftUI allows lists in popovers.
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Vibes")
                .font(.title2)
            TextField("Filter Vibes", text: $filterString)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    OutlineGroup(rootContainers.filter({$0.inVibeTree == true}).first?.childArray ?? [], children: \.childArray) { item in
                        switch item {
                        
                        /// If this is a vibe, we check to see if there's any text in the filter field.
                        /// If there *is*, we hide any rows that don't match it by returning an EmptyView. Otherwise, we show a VibeEditRow, which contains all the logic for tapping and stuff.
                        case let vibe as Vibe:
                            if filterString.count > 0 && !(item.name?.lowercased().contains(filterString.lowercased()) ?? true) {
                                    EmptyView()
                                        .frame(maxWidth: .infinity)
                                } else {
                                    HStack {
                                        VibeEditRow(track: track, vibe: vibe)
                                        Spacer()
                                    }
                                        .frame(maxWidth: .infinity)
                                }


                        case let folder as Folder:
                            HStack {
                                Text(folder.name ?? "")
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .truncationMode(.middle)
                                    .padding(.horizontal, 3)
                                    .padding(.vertical, 0)
                                Spacer()
                            }
                                .frame(maxWidth: .infinity)
                        default:
                            EmptyView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
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
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.middle)
                .padding(.horizontal, 3)
                .padding(.vertical, 1)
                .background(Color.accentColor)
                .cornerRadius(5.0)
                .onTapGesture {
                    vibe.removeFromTracks(track)
                    try! moc.save()
                }
        } else {
            Text(vibe.name ?? "")
                .lineLimit(1)
                .truncationMode(.middle)
                .padding(.horizontal, 3)
                .padding(.vertical, 1)
                .cornerRadius(5.0)
                .onTapGesture {
                    vibe.addToTracks(track)
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
