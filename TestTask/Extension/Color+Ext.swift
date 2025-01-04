//
//  Color+Ext.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//


import SwiftUICore

extension Color {
    public struct Background {
        public static var darkSecondary: Color {
            return .init(red: 51 / 255.0,
                         green: 51 / 255.0,
                         blue: 51 / 255.0)
        }

        public static var secondary: Color {
            return .init(red: 242 / 255.0,
                         green: 242 / 255.0,
                         blue: 242 / 255.0)
        }

        public static var light: Color {
            return .init(red: 250 / 255.0,
                         green: 250 / 255.0,
                         blue: 250 / 255.0)
        }
    }
}
