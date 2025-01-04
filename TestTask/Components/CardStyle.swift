//
//  CardStyle.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .padding(.all, .s14)
            .background(Color.white)
            .cornerRadius(.r10)
            .shadow(color: .Background.secondary, radius: .r10, x: .s2, y: .s2)
    }

    func horizontalPadding() -> some View {
        self.padding(.horizontal, .s16)
    }
    
    func verticalPadding() -> some View {
        self.padding(.vertical, .s16)
    }
}
