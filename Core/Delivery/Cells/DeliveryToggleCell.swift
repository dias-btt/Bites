//
//  DeliveryToggleCell.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import SwiftUI

struct DeliveryToggleCell: View {
    let title: String
    let subtitle: String
    let iconName: String
    @Binding var isToggled: Bool // Binding to manage toggle state

    var body: some View {
        HStack {
            Image(iconName) // Icon for the delivery option
                .foregroundColor(Color("Primary"))

            VStack {
                Text(title) // Title text
                    .font(.custom("SF-Pro-Display-Regular", size: 15))
                    .foregroundColor(Color("Primary"))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(subtitle) // Subtitle text
                    .font(.custom("SF-Pro-Display-Regular", size: 13))
                    .foregroundColor(Color("Primary"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 8)

            Spacer()

            Toggle(isOn: $isToggled) {
                Text("") // An empty text to hide toggle label
            }
            .labelsHidden() // Hide the toggle label
        }
        .padding()
        .background(Color("Fifth"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    DeliveryToggleCell(
        title: "Option with Toggle",
        subtitle: "Subtitle for this option",
        iconName: "switch.2",
        isToggled: .constant(false) // Test with a constant value
    )
}
