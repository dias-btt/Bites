//
//  CustomButtonView.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

struct CustomButtonView: View {
    var action: () -> Void
    var label: String
    var isDisabled: Bool
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(isDisabled ? Color("Secondary") : Color.white)
                .font(.custom("SF-Pro-Display-Regular", size: 17))
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(isDisabled ? Color("Fifth") : Color("Primary"))
                .cornerRadius(20)
                .padding(.horizontal, -8)
        }
        .disabled(isDisabled)
        .padding(.top, 15)
    }
}
