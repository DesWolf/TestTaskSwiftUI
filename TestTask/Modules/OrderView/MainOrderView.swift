//
//  OrderView.swift
//  TestTask
//
//  Created by MaxOkuneev on 05.11.2024.
//

import SwiftUI
import Combine

struct MainOrderView: View {
    @ObservedObject var viewModel: MainOrderViewModel

    @Namespace var animation

    private var adressView: some View {
        ZStack {
            if let addressViewModel = viewModel.addressViewModel {
                AddressView(viewModel: addressViewModel)
            } else {
                EmptyView()
            }
        }
    }

    private var paymentMethodView: some View {
        ZStack {
            if let paymentViewModel = viewModel.paymentMethodViewModel {
                PaymentMethodView(viewModel: paymentViewModel)
            } else {
                EmptyView()
            }
        }
    }

    private var orderSummaryView: some View {
        ZStack {
            if let orderSummaryViewModel = viewModel.orderSummaryViewModel {
                OrderSummaryView(viewModel: orderSummaryViewModel)
            } else {
                EmptyView()
            }
        }
    }

    var body: some View {
        Group {
            switch viewModel.orderState {
            case .address:
                adressView
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            case .paymentMethod:
                paymentMethodView
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            case .summary:
                orderSummaryView
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            }
        }

    }


}

#Preview {
    MainOrderView(
        viewModel: MainOrderViewModel(
            orderService: OrderService(),
            dismissHandler: {}
        )
    )
}
