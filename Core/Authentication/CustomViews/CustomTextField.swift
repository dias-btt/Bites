//
//  CustomTextField.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

// Custom view for text field with label
struct CustomTextField: View {
    var label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType
    var isValid: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            Text(text.isEmpty ? label : (isValid ? label : "Неверный формат email"))
                .font(.custom("SF Pro Display Regular", size: 15))
                .foregroundColor(text.isEmpty ? Color("Tertiary") : (isValid ? Color("Tertiary") : .red))
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", text: $text)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(.never)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(text.isEmpty ? .black : (isValid ? .black : .red), lineWidth: 1)
                )
                .padding(.horizontal, -3)
        }
        .padding(.top)
    }
}

