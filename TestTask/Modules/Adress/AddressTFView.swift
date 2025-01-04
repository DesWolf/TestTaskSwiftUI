//
//  AddressTFView.swift
//  TestTask
//
//  Created by MaxOkuneev on 07.11.2024.
//

import SwiftUI
import Combine

struct AddressTFView: View {
    @Binding var address: String

    var body: some View {
            TextField(
                Consts.placeholder,
                text: $address
            )
            .cardStyle()
        }
}

private enum Consts {
    static let placeholder = "Please enter your address"
}

struct AddressTFView_Previews: PreviewProvider {
    static var previews: some View {
        AddressPreviewWrapper()
    }

    struct AddressPreviewWrapper: View {
        @State private var address = "test"

        var body: some View {
            AddressTFView(address: $address)
        }
    }
}
