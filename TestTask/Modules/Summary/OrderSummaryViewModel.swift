//
//  OrderSummaryViewModel.swift
//  TestTask
//
//  Created by MaxOkuneev on 03.11.2024.
//

import Foundation
import SwiftUICore
import Combine

final class OrderSummaryViewModel: ObservableObject {
    enum DetaiView {
        case address
        case paymentMethod
    }


    // MARK: - Public Properties

    @Published var address: String = ""
    @Published var paymentMethodText: String = ""

    @Published var selectedPaymentMethod: OrderService.PaymentMethod?
    @Published var selectedInstallmentType: OrderService.InstallmentType?

    // MARK: - Private Properties

    private let orderService: OrderService
    private let mainHandler: (() -> Void)?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        orderService: OrderService,
        mainHandler: (() -> Void)?

    ) {
        self.orderService = orderService
        self.mainHandler = mainHandler

        configure()
    }

    // MARK: - Internal Methods

    func sendOrder() {
        // запрос на заказ

        mainHandler?()
    }

    func updateData() {
        self.selectedPaymentMethod = orderService.selectedPaymentMethod.value
        self.selectedInstallmentType = orderService.selectedInstallmentType.value
        
        address = orderService.address.value
        paymentMethodText = selectedPaymentMethod == .installment ? 
            "\(selectedPaymentMethod?.id ?? "") (\(selectedInstallmentType?.id ?? ""))" :
            selectedPaymentMethod?.id ?? ""
    }

    //MARK: - Private Methods

    private func configure() {
        updateData()

        $address
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] updatedAddress in

                self?.orderService.address.send(updatedAddress)
            }
            .store(in: &cancellables)

        $selectedPaymentMethod
            .receive(on: DispatchQueue.main)
            .filter { $0 != nil }
            .sink {
                [weak self] updatedPaymentMethod in

                self?.orderService.selectedPaymentMethod.send(updatedPaymentMethod)
            }
            .store(in: &cancellables)

        $selectedInstallmentType
            .receive(on: DispatchQueue.main)
            .filter { $0 != nil }
            .sink {
                [weak self] updatedInstalmentType in

                self?.orderService.selectedInstallmentType.send(updatedInstalmentType)
            }
            .store(in: &cancellables)
    }
}
