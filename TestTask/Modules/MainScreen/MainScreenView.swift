//
//  MainScreenView.swift
//  TestTask
//
//  Created by MaxOkuneev on 02.11.2024.
//

import SwiftUI

struct MainScreenView: View {
    @State var showOrder: Bool = false

    var body: some View {
        ZStack {
            if showOrder {
                MainOrderView(viewModel: MainOrderViewModel(
                    orderService: OrderService(),
                    dismissHandler: {
                        showOrder = false
                    }
                ))
            } else {
                Button(Consts.buttonTitle) {
                    showOrder = true
                }
                .buttonStyle(BaseButtonStyle(type: .brand))
                .horizontalPadding()
            }
        }
    }
}

private enum Consts {
    static let buttonTitle = "Order"
}

#Preview {
    MainScreenView()
}
