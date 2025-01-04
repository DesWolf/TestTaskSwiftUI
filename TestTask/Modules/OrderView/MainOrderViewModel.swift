//
//  OrderViewModel.swift
//  TestTask
//
//  Created by MaxOkuneev on 05.11.2024.
//

import Foundation
import SwiftUICore
import Combine

final class MainOrderViewModel: ObservableObject {
    enum OrderState: Equatable {
        case address
        case paymentMethod
        case summary
    }

    // MARK: Internal Properties

    @Published var orderState: OrderState = .address

    var addressViewModel: AddressViewModel?
    var paymentMethodViewModel: PaymentMethodViewModel?
    var orderSummaryViewModel: OrderSummaryViewModel?

    // MARK: - Private Properties

    private let orderService: OrderService
    private let dismissHandler: (() -> Void)?

    // MARK: - Init

    init(
        orderService: OrderService,
        dismissHandler: (() -> Void)?
    ) {
        self.orderService = orderService
        self.dismissHandler = dismissHandler
        configure()
    }

    // MARK: Private Methods

    private func configure() {
        addressViewModel = .init(
            orderService: orderService,
            buttonHandler: {
                [weak self] in

                self?.updateOrderState(to: .paymentMethod)
            }
        )

        paymentMethodViewModel = .init(
            orderService: orderService,
            buttonHandler: {
                [weak self] in

                self?.updateOrderState(to: .summary)
            }
        )

        orderSummaryViewModel = .init(
            orderService: orderService,
            mainHandler: {
                [weak self] in

                self?.dismissHandler?()
            }
        )
    }

    private func updateOrderState(to newState: OrderState) {
        withAnimation(.easeInOut(duration: 0.2)) {
            orderState = newState
        }
    }
}
