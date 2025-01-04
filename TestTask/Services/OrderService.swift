//
//  OrderService.swift
//  TestTask
//
//  Created by MaxOkuneev on 03.11.2024.
//

import Combine
import SwiftUI


final class OrderService: ObservableObject {
    enum PaymentMethod: CaseIterable, Identifiable {
        var id: String { self.displayName }

        case cash
        case card
        case installment

        private var displayName: String {
            switch self {
            case .cash:
                return "Cash"
            case .card:
                return "Card"
            case .installment:
                return "Installment"
            }
        }
    }

    enum InstallmentType: CaseIterable, Identifiable {
        var id: String { self.displayName }

        case oneMonth
        case threeMonth
        case sixMonth

        private var displayName: String {
            switch self {
            case .oneMonth:
                return "1 month"
            case .threeMonth:
                return "3 months"
            case .sixMonth:
                return "6 months"
            }
        }
    }

    var address = CurrentValueSubject<String, Never>("")
    var selectedPaymentMethod = CurrentValueSubject<PaymentMethod?, Never>(.card)
    var selectedInstallmentType = CurrentValueSubject<InstallmentType?, Never>(.sixMonth)

    @Namespace var animation
}
