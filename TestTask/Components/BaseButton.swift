//
//  BaseButton.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled: Bool

    private var type: AppButtonType

    init(type: AppButtonType) {
        self.type = type
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(isEnabled ? type.textColor : Color.secondary)
            .background(isEnabled ? type.backgroundColor : Color(UIColor.systemGray5))
            .cornerRadius(type.cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .frame(height: 50)
    }
}

#Preview {
    Button("Standart", action: { })
        .buttonStyle(BaseButtonStyle(type: .brand))
        .frame(height: 40)
}

enum AppButtonType {
    case brand

    var backgroundColor: Color {
        switch self {
        case .brand: return Color.Background.darkSecondary
        }
    }
    
    var textColor: Color {
        switch self {
        case .brand:
            return .white
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .brand:
            return 10
        }
    }
}
