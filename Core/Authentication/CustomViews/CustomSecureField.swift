//
//  CustomSecureField.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import Foundation
import SwiftUI

struct CustomSecureField: View {
    var label: String
    @Binding var text: String
    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("SF-Pro-Display-Regular", size: 15))
                .foregroundColor(Color("Tertiary"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
                
                Button(action: {
                    isSecure.toggle()
                }, label: {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(Color("Tertiary"))
                })
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(.horizontal, -3)
        }
        .padding(.top)
    }
}

