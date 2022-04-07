//
//  TextField+ViewModifier.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/5/22.
//

import SwiftUI

struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var color: Color
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(height: 10)
            .padding()
            .background(color)
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .font(.custom("Open Sans", size: 14))
    }
}
