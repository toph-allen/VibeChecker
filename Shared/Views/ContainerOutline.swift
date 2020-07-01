//
//  ContainerOutline.swift
//  VibeChecker
//
//  Created by Toph Allen on 6/25/20.
//

import Foundation
import SwiftUI
import CoreData


struct ExtractedView: View {
    var rootContainers: [Container]
    
    var body: some View {
        List {
            OutlineGroup(rootContainers, children: \.childArray) { item in
                Text("\(item.name ?? "")")
            }
        }.listStyle(SidebarListStyle())
    }
}

struct ContainerOutline_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
