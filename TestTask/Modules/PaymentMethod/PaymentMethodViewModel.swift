//
//  PaymentMethodViewModel.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import Foundation
import SwiftUICore
import Combine

final class PaymentMethodViewModel: ObservableObject {
    
    // MARK: - Internal Properties

    @Published var selectedPaymentMethod: OrderService.PaymentMethod?
    @Published var selectedInstallmentType: OrderService.InstallmentType?

    //MARK: - Private Properties

    private let orderService: OrderService
    private let buttonHandler: (() -> Void)?

    private var cancellables = Set<AnyCancellable>()

    // MARK: Init

    init(
        orderService: OrderService,
        buttonHandler: (() -> Void)?
    ) {
        self.orderService = orderService
        self.buttonHandler = buttonHandler

        configure()
    }

    // MARK: - Internal methods

    func syncDataFromOrderService() {
        self.selectedPaymentMethod = orderService.selectedPaymentMethod.value
        self.selectedInstallmentType = orderService.selectedInstallmentType.value
    }

    func showOrderSummary() {
        guard selectedPaymentMethod != nil else {
            return
        }
        buttonHandler?()
    }

    // MARK: - Private methods

    private func configure() {
        syncDataFromOrderService()

        bind($selectedPaymentMethod, to: orderService.selectedPaymentMethod)
        bind($selectedInstallmentType, to: orderService.selectedInstallmentType)
    }


    private func bind<T>(
        _ published: Published<T?>.Publisher,
        to subject: CurrentValueSubject<T?, Never>
    ) {
        published
            .receive(on: DispatchQueue.main)
            .filter { $0 != nil }
            .sink { updatedValue in
                subject.send(updatedValue)
            }
            .store(in: &cancellables)
    }
}
