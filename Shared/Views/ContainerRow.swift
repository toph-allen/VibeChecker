//
//  ContainerRow.swift
//  VibeChecker
//
//  Created by Toph Allen on 7/1/20.
//

import SwiftUI

struct ContainerRow: View {
    let container: Container
    init(_ container: Container) {
        self.container = container
    }
    
    var body: some View {
        Label(container.name ?? "", systemImage: imageName(for: type(of: container)))
    }
}

//struct ContainerRow_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        ContainerRow()
//    }
//}
