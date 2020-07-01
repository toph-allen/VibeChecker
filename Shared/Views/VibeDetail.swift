//
//  VibeDetail.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct VibeDetail: View {
    @ObservedObject var vibe: Vibe
    @State var selectedTrack: Track?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            NavigationView {
                List(selection: $selectedTrack) {
                    ForEach(vibe.tracks?.allObjects as! [Track]) { track in
                        TrackRow(track).tag(track)
                    }
                }
                if selectedTrack != nil {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(selectedTrack!.title ?? "")
                            .font(.title2)
                        
                        Text("Vibes")
                            .font(.headline)
                            .padding(.top, 2)
                        
                        TagCloudView(tags: selectedTrack!.vibes?.allObjects.map({($0 as! Vibe).name}) as! [String])
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("No Vibe Selected")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.tertiaryLabel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

    }
}

//struct VibeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        VibeDetail()
//    }
//}
