//
//  MyCustomButton.swift
//  Bites
//
//  Created by Диас Сайынов on 27.04.2024.
//

import SwiftUI

struct MyCustomButton: View {
    let title: String
    let action: () -> Void
    let isActive: Bool

    var body: some View {
        Button(action: {
            if isActive {
                action()
            }
        }) {
            Text(title)
                .font(.custom("SF Pro Display Bold", size: 17))
                .foregroundColor(isActive ? .white : Color("Secondary"))
                .padding(.vertical)
                .padding(.horizontal, 100)
                .background(isActive ? Color("Primary") : Color("Fifth"))
                .cornerRadius(20)
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}
