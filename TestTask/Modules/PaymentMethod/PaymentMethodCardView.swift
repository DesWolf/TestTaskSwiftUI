//
//  PaymentMethodCardView.swift
//  TestTask
//
//  Created by MaxOkuneev on 07.11.2024.
//

import SwiftUI

struct PaymentMethodCardView: View {
    private let paymentMethods = OrderService.PaymentMethod.allCases
    private let installmentsType = OrderService.InstallmentType.allCases

    @Binding var selectedPaymentMethod: OrderService.PaymentMethod?
    @Binding var selectedInstallmentType: OrderService.InstallmentType?

    var body: some View {
        VStack {
            selectableList(items: paymentMethods, selectedItem: $selectedPaymentMethod)
                .padding(.bottom, .s30)

            if selectedPaymentMethod == .installment {
                selectableList(items: installmentsType, selectedItem: $selectedInstallmentType)
            }
        }
        .horizontalPadding()
    }

    private func selectableList<T: Identifiable & Equatable>(
        items: [T],
        selectedItem: Binding<T?>
    ) -> some View {
        VStack {
            ForEach(items) { item in
                HStack {
                    Text("\(item.id)")
                    Spacer()
                    if selectedItem.wrappedValue == item {
                        Image(systemName: Consts.checkMarkImageName)
                    }
                }
                .padding(.vertical, .s10)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedItem.wrappedValue = item
                }
            }
            .cardStyle()
        }
    }
}

private enum Consts {
    static let checkMarkImageName = "checkmark"
}

struct PaymentMethodCardView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodPreviewWrapper()
    }

    struct PaymentMethodPreviewWrapper: View {
        @State var selectedPaymentMethod: OrderService.PaymentMethod? = .card
        @State var selectedInstallmentType: OrderService.InstallmentType? = .oneMonth

        var body: some View {
            PaymentMethodCardView(selectedPaymentMethod: $selectedPaymentMethod, selectedInstallmentType: $selectedInstallmentType)
        }
    }
}
