//
//  PaymentMethodView.swift
//  Bites
//
//  Created by Диас Сайынов on 28.04.2024.
//

import SwiftUI

enum PaymentMethod: Equatable {
    case card(Card) // Represents a specific card
    case applePay
    case cash
    
    // Implement the '==' function to compare two PaymentMethods
    static func == (lhs: PaymentMethod, rhs: PaymentMethod) -> Bool {
        switch (lhs, rhs) {
        case (.card(let leftCard), .card(let rightCard)):
            return leftCard.cardnum == rightCard.cardnum // Compare card numbers to check equality
        case (.applePay, .applePay), (.cash, .cash):
            return true // Apple Pay and Cash are equal to themselves
        default:
            return false // Any other case is not equal
        }
    }
}


struct PaymentMethodView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var card: String = ""
    @State private var isApplePay: Bool = false
    @State private var isCash: Bool = false
    @StateObject private var paymentsViewModel = PaymentsViewModel()
    
    @Binding var selectedPaymentMethod: PaymentMethod?
    var cards: [Card]? = []

    var body: some View {
        NavigationView {
            VStack {
                // Back button and title
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
                    
                    Text("Способы оплаты")
                        .font(.custom("SF-Pro-Display-Bold", size: 34))
                    
                    Spacer()
                }
                
                Text("Кредитные и дебетовые карты")
                    .font(.custom("SF-Pro-Display-Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                ForEach(paymentsViewModel.cards, id: \.cardnum) { card in
                    HStack{
                        Image("visa")
                            .resizable()
                            .frame(width: 52, height: 36)
                        VStack{
                            Text("Card")
                                .font(.custom("SF-Pro-Display-Bold", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("**** **** **** \(String(card.cardnum.suffix(4)))")
                                .font(.custom("SF-Pro-Display-Bold", size: 12))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.gray)
                        }
                        Spacer()
                        Image(systemName: (selectedPaymentMethod == .card(card)) ? "check" : "uncheck")
                                .foregroundColor(Color("Primary"))
                                .onTapGesture {
                                    selectedPaymentMethod = .card(card) // Select card as payment method
                                }
                    }
                }
                
                // Navigation link to add a new card
                NavigationLink {
                    AddPaymentView().navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(Color("Primary"))
                        Text("Добавить новую карту")
                            .font(.custom("SF-Pro-Display-Bold", size: 15))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
                
                Divider()
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                Text("Другие способы оплаты")
                    .font(.custom("SF-Pro-Display-Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                HStack {
                    Image("applePay")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 52, height: 36)
                    
                    Text("Apple Pay")
                        .font(.custom("SF-Pro-Display-Bold", size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(isApplePay ? "check" : "uncheck")
                        .foregroundColor(Color("Primary"))
                        .onTapGesture {
                            isApplePay.toggle()
                            if isCash{
                                isCash.toggle()
                            }
                            selectedPaymentMethod = isApplePay ? .applePay : nil
                        }
                }
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    Image("cash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 52, height: 36)
                    
                    Text("Наличные")
                        .font(.custom("SF-Pro-Display-Bold", size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(isCash ? "check" : "uncheck")
                        .foregroundColor(Color("Primary"))
                        .onTapGesture {
                            isCash.toggle()
                            if isApplePay{
                                isApplePay.toggle()
                            }
                            selectedPaymentMethod = isCash ? .cash : nil
                        }
                }
                Divider()
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView(selectedPaymentMethod: .constant(nil))
    }
}
