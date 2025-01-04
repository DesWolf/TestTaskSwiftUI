//
//  AddressView.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var viewModel: AddressViewModel

    private var addressTFView: some View {
        AddressTFView(
            address: $viewModel.address)
    }

    private var buttonView: some View {
        Button(
            Consts.buttonTitle,
            action: {
                viewModel.showPaymentMethods()
            })
        .buttonStyle(BaseButtonStyle(type: .brand))
        .disabled(viewModel.address.isEmpty)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(Consts.title)
                .font(.title2)
            addressTFView
            Spacer()
            buttonView
        }
        .background(Consts.bgColor)
        .horizontalPadding()
        .verticalPadding()
        .onAppear {
            viewModel.syncDataFromOrderService()
        }
    }
}

private enum Consts {
    static let title = "Address"
    static let placeholder = "Please enter your address"
    static let buttonTitle = "Continue"
    static let bgColor = Color.white
}


struct Address_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(
            viewModel:
                AddressViewModel(
                    orderService: OrderService(),
                    buttonHandler: {}
                )
        )
    }
}
