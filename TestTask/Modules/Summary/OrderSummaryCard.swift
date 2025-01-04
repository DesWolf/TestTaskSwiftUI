//
//  OrderSummaryCard.swift
//  TestTask
//
//  Created by MaxOkuneev on 07.11.2024.
//

import SwiftUI

struct OrderSummaryCard: View {

    @State var title: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: .s15) {
                Text(title)
                    .font(.title2)
                Spacer()
            }
            Spacer()
        }
        .cardStyle()
    }
}

#Preview {
    OrderSummaryCard(title: "test")
}
