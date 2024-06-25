//
//  AddPaymentView.swift
//  Bites
//
//  Created by Диас Сайынов on 28.04.2024.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var securityCode: String = ""
    
    @StateObject private var paymentsViewModel = PaymentsViewModel()
    
    var fieldsFilled: Bool {
        !cardNumber.isEmpty && !expirationDate.isEmpty && !securityCode.isEmpty
    }

    // Function to format card number with space every 4 digits
    func formattedCardNumber(_ number: String) -> String {
        let cleanedNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let groupedNumber = cleanedNumber.enumerated().map { index, digit in
            (index % 4 == 0 && index > 0) ? " \(digit)" : String(digit)
        }.joined()
        
        return String(groupedNumber.prefix(19)) // Limit to 19 characters (16 digits + 3 spaces)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("Добавить карту")
                        .font(.custom("SF-Pro-Display-Bold", size: 34))
                    
                    Spacer()
                }
                .padding()

                ZStack {
                    Image("addcard")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .cornerRadius(20)

                    VStack {
                        // Card number
                        Text("Номер карты")
                            .font(.custom("SF-Pro-Display-Regular", size: 15))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("0000 0000 0000 0000", text: $cardNumber)
                            .keyboardType(.numberPad)
                            .onChange(of: cardNumber) { newCardNumber in
                                cardNumber = formattedCardNumber(newCardNumber) // Format card number
                            }
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, -3)
                        
                        HStack{
                            VStack{
                                Text("Срок действия")
                                    .font(.custom("SF-Pro-Display-Regular", size: 15))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("MM/YY", text: $expirationDate)
                                    .keyboardType(.numberPad)
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.horizontal, -3)
                            }
                            .padding(.trailing, 8)
                            VStack{
                                Text("Код безопасности")
                                    .font(.custom("SF-Pro-Display-Regular", size: 15))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("000", text: $securityCode)
                                    .keyboardType(.numberPad)
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.horizontal, -3)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .frame(width: 390, height: 232)
                
                Text("Вы можете использовать дебетовую или кредитную карту для заказов через Bites. Оплата будет списана с карты только после доставки заказа.")
                    .font(.custom("SF-Pro-Display-Regular", size: 15))
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                MyCustomButton(title: "Сохранить",
                    action: {
                    Task {
                        if fieldsFilled {
                            // Create a card instance
                            let card = Card(
                                cardnum: cardNumber,
                                expirationDate: expirationDate,
                                securityCode: securityCode
                            )
                            await paymentsViewModel.saveCard(card: card)
                            presentationMode.wrappedValue.dismiss() // Close the view
                        }
                    }
                },
                isActive: fieldsFilled)
            }
            .padding()
        }
    }
}

struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView()
    }
}

