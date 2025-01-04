//
//  AddressViewModel.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import Foundation
import SwiftUICore
import Combine

final class AddressViewModel: ObservableObject {

    // MARK: - Internal Properties

    @Published var address: String = ""

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

    // MARK: - Internal Methods

    func syncDataFromOrderService() {
        self.address = orderService.address.value
    }

    func showPaymentMethods() {
        guard !address.isEmpty else {
            return
        }

        buttonHandler?()
    }

    //MARK: - Private Methods

    private func configure() {
        $address
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] updatedAddress in

                self?.orderService.address.send(updatedAddress)
            }
            .store(in: &cancellables)

        syncDataFromOrderService()
    }
}

