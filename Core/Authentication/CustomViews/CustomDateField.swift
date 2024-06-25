//
//  File.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

struct CustomDateField: View {
    var label: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.custom("SF-Pro-Display-Regular", size: 15))
                .foregroundColor(Color("Tertiary"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, -3)
        }
        .padding(.top)
    }
}
