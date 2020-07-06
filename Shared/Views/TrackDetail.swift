//
//  TrackDetailView.swift
//  iOS
//
//  Created by Toph Allen on 7/5/20.
//

import SwiftUI

struct TrackDetail: View {
    @Environment(\.managedObjectContext) var moc

    @ObservedObject var track: Track
    @State var presentingVibePopover: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(track.title ?? "")
                .font(.title)
        
            HStack(alignment: .bottom) {
                HStack(alignment: .top) {
                    Text("Vibes:")
//                        .font(.headline)
                        .padding(.top, 2)
                    
                    TagCloudView(tags: track.vibes?.allObjects.map({($0 as! Vibe).name}) as! [String])
                }
                
                Button(action: {
                    presentingVibePopover = true
                }, label: {
                    Label("", systemImage: "ellipsis.circle")
                })
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.secondary)
                .popover(isPresented: $presentingVibePopover, content: {
                    VibeEditView(track: track)
                        .environment(\.managedObjectContext, self.moc)
                        .padding()
                        .frame(minWidth: 256, idealWidth: 256, maxWidth: 256, minHeight: 512, idealHeight: 768, maxHeight: 1024)

                })
            }
            
//            Divider()
            
//            VibeEditView(track: track)
            
            Spacer()
        }
        .padding()

    }
}

//struct TrackDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackDetail()
//    }
//}
