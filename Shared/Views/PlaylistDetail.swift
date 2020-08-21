//
//  PlaylistDetail.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct PlaylistDetail: View {
    @ObservedObject var playlist: Playlist
    @State var selectedTrack: PlaylistTrack?
    
    @FetchRequest var tracks: FetchedResults<PlaylistTrack>
    
    init(playlist: Playlist) {
        self.playlist = playlist
        
        let request: NSFetchRequest<PlaylistTrack> = PlaylistTrack.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = NSPredicate(format: "playlist == %@", playlist)
        
        self._tracks = FetchRequest<PlaylistTrack>(fetchRequest: request)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            
            HStack {
                ScrollView() {
                    LazyVStack(alignment: .leading, spacing: 0, content: {
                        ForEach(tracks) { track in
                            HStack() {
                                Group() {
                                    StackRow(track)
                                    Spacer()
                                }
                            }
                            .foregroundColor(track == $selectedTrack.wrappedValue ? Color.white : Color.text)
                            .background(track == $selectedTrack.wrappedValue ? Color("SelectionColor") : Color.textBackground)
                                .cornerRadius(5)
                            .onTapGesture {
                                $selectedTrack.wrappedValue = track
                            }
                        }
                    })
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.textBackground)
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(width: 256)
                
                if selectedTrack != nil {
                    // This is actually a track detail view or an inspector
                    TrackDetail(track: selectedTrack!.track!)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("No Track Selected")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.tertiaryLabel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }


            }
            

                



        }
    }
}

struct StackRow: View {
    let track: Track
    
    init(_ track: Track) {
        self.track = track
    }
    
    init(_ playlistTrack: PlaylistTrack) {
        self.track = playlistTrack.track!
    }
    
    var body: some View {
        TrackRow(track)
            .padding(EdgeInsets(top: 1, leading: 14, bottom: 1, trailing: 14))
            .edgesIgnoringSafeArea(.horizontal)
    }
}

//struct PlaylistDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaylistDetail()
//    }
//}
