//
//  SpendBonusesModalView.swift
//  Bites
//
//  Created by Диас Сайынов on 12.05.2024.
//
import SwiftUI

struct SpendBonusesModalView: View {
    let bonuses: Int
    @Environment(\.presentationMode) var presentationMode
    @Binding var commentText: String
    @State private var isError: Bool = false
    
    var body: some View {
        VStack {
            Text("Укажите, сколько бонусов вы хотите потратить")
                .font(.custom("SF-Pro-Display-Regular", size: 24))
                .multilineTextAlignment(.center)
            
            Text(commentText.isEmpty ? "Сколько бонусов" : (isError ? "Не хватает бонусов" : "Отлично!"))
                .font(.custom("SF-Pro-Display-Regular", size: 15))
                .foregroundStyle(commentText.isEmpty ? Color.gray : (isError ? .red : .green))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)

            TextField("", text: $commentText)
                .onChange(of: commentText) {
                    isError = Int(commentText) ?? 0 > bonuses
                }
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            MyCustomButton(title: "Сохранить", action: {
                presentationMode.wrappedValue.dismiss()
            }, isActive: !commentText.isEmpty && !isError)
            .padding(.top, 20)

        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}
