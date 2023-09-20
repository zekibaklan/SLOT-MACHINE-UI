//
//  Extensions.swift
//  Slot Machine
//
//  Created by Zeki Baklan on 18.09.2023.
//

import SwiftUI

extension Text {
    
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10,weight: .bold,design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
        .foregroundColor(.white)
        .font(.system(.title,design: .rounded))
        .fontWeight(.heavy)
       
    }
    
}
