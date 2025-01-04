//
//  PaymentMethodView.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

struct PaymentMethodView: View {
    @ObservedObject var viewModel: PaymentMethodViewModel

    private var paymentMethodsView: some View {
        PaymentMethodCardView(
            selectedPaymentMethod: $viewModel.selectedPaymentMethod,
            selectedInstallmentType: $viewModel.selectedInstallmentType)
    }

    private var buttonView: some View {
        Button(
            Consts.buttonTitle,
            action: {
                viewModel.showOrderSummary()
            })
        .buttonStyle(BaseButtonStyle(type: .brand))
    }

    var body: some View {
        VStack() {
            paymentMethodsView
            Spacer()
            buttonView
        }
        .background(Consts.backgroundColor)
        .horizontalPadding()
        .verticalPadding()
        .onAppear {
            viewModel.syncDataFromOrderService()
        }
    }
}

private enum Consts {
    static let paymentTitle = "Payment method"
    static let installmentTitle = "Installment Type"
    static let buttonTitle = "Continue"
    static let backgroundColor = Color.white
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView(
            viewModel:
                PaymentMethodViewModel(
                    orderService: OrderService(),
                    buttonHandler: {}
                )
        )
    }
}

