//
//  OrderSummaryView.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

struct OrderSummaryView: View {

    @ObservedObject var viewModel: OrderSummaryViewModel
    @Namespace var animation

    @State var showDetailView: Bool = false
    @State var detailView: OrderSummaryViewModel.DetaiView?

    var body: some View {
        ZStack(alignment: .leading) {

            // всплывающее вью с редактированием
            if showDetailView {
                VStack(alignment: .leading) {
                    closeButtonView()

                    if detailView == .address {
                        addressContentView()
                            .padding(.top, .s15)
                    } else if detailView == .paymentMethod {
                        paymentMethodContentView()
                            .padding(.top, .s15)
                    }

                    Spacer()
                }

                // базовое вью
            } else {
                VStack(alignment: .leading) {

                    //карточка с адресом
                    addressContentView()

                    //карточка с типом оплаты
                    paymentMethodContentView()
                        .padding(.top, .s15)

                    Spacer()

                    //кнопка заказа
                    bottomButtonView(
                        title: Consts.buttonTitle,
                        handler: {
                            viewModel.sendOrder()
                        })
                }
                .verticalPadding()
                .onAppear {
                    viewModel.updateData()
                }
            }
        }
        .background(Color.white)
        .horizontalPadding()
    }

    // MARK: - Private methods

    @ViewBuilder
    private func addressContentView() -> some View {
        ZStack(alignment: .top) {
            OrderSummaryCard(
                title: Consts.addressTitle
            )
            .matchedGeometryEffect(id: "title", in: animation)
            .frame(height: showDetailView ? 600 : 100)
            .onTapGesture {
                withAnimation {
                    detailView = .address
                    showDetailView = true
                }
            }
            ZStack(alignment: .leading) {
                if showDetailView {
                    AddressTFView(
                        address: $viewModel.address
                    )
                } else {
                    HStack {
                        Text(viewModel.address)
                            .font(.title3)
                        Spacer()
                    }
                }
            }
            .matchedGeometryEffect(id: "address", in: animation)
            .padding(.top, 60)
            .padding(.horizontal, 14)
        }
    }

    @ViewBuilder
    private func paymentMethodContentView() -> some View {
        ZStack(alignment: .top) {
            OrderSummaryCard(
                title: Consts.paymentTitle
            )
            .matchedGeometryEffect(id: "title2", in: animation)
            .frame(height: showDetailView ? 600 : 100)
            .onTapGesture {
                withAnimation {
                    detailView = .paymentMethod
                    showDetailView = true
                }
            }

            if showDetailView {
                ZStack(alignment: .leading) {
                    PaymentMethodCardView(
                        selectedPaymentMethod: $viewModel.selectedPaymentMethod,
                        selectedInstallmentType: $viewModel.selectedInstallmentType
                    )
                }
                .padding(.horizontal, 14)
                .padding(.top, 60)
                .matchedGeometryEffect(id: "paymentMethod", in: animation)
            } else {
                HStack {
                    Text(viewModel.paymentMethodText)
                        .font(.title3)
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.top, 60)
            }
        }
    }

    private func closeButtonView() -> some View {
        HStack{
            Spacer()
            Button(action: {
                withAnimation {
                    showDetailView = false
                }
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .frame(width: 40, height: 40)
            .padding(.trailing, 15)
        }
    }

    private func bottomButtonView(
        title: String,
        handler: (() -> Void)?
    ) -> some View {
        Button(
            title,
            action: {
                handler?()
            })
        .buttonStyle(BaseButtonStyle(type: .brand))
        .frame(height: 50)
    }

}

private enum Consts {
    static let addressTitle = "Address"
    static let paymentTitle = "Payment method"
    static let buttonTitle = "Order"
}


struct OrderSummary_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummaryView(
            viewModel: OrderSummaryViewModel(
                orderService: OrderService(),
                mainHandler: {}
            )
        )
    }
}
