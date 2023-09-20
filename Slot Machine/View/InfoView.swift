//
//  InfoView.swift
//  Slot Machine
//
//  Created by Zeki Baklan on 20.09.2023.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment : .center ,spacing: 10) {
            LogoView()
            Spacer()
            Form {
                Section(header: Text("About the application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone,iPad,Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Zeki Baklan")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website", secondItem: "zekibaklan.com")
                    FormRowView(firstItem: "Copyright", secondItem: "© 2023 All rights reserved.")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                    
                }
            }
            .font(.system(.body,design: .rounded))
        }
        .padding(.top,40)
        .overlay(
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            })
            .padding(.top,30)
            .padding(.trailing,20)
            .accentColor(.secondary)
            ,alignment: .topTrailing
        
        )
    }
}
struct FormRowView: View {
    var firstItem : String
    var secondItem : String
    
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundStyle(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

#Preview {
    InfoView()
}


