//
//  ReelView.swift
//  Slot Machine
//
//  Created by Zeki Baklan on 19.09.2023.
//

import SwiftUI

struct ReelView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
}

#Preview {
    
    ReelView()
        .previewLayout(.fixed(width: 220, height: 220))
}
