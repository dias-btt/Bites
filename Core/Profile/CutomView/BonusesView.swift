//
//  BonusesView.swift
//  Bites
//
//  Created by Диас Сайынов on 28.04.2024.
//

import SwiftUI

struct BonusesView: View {
    @Environment(\.presentationMode) var presentationMode
    let bonuses: Int
    let history: [OrderResult]

    var body: some View {
        NavigationView {
            ZStack {
                // Full-screen background image
                Image("bonuses")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()

                VStack {
                    Spacer()
                    HStack {
                        // Back button
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 28, height: 28)
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("Primary"))
                            }
                        }
                        // Title text
                        Text("У Вас \(bonuses) Бонуса")
                            .font(.custom("SF Pro Display Bold", size: 34))
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    Text("Как потратить?")
                        .font(.custom("SF Pro Display Bold", size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("При оформлении заказа и выборе оплаты, после этого будет предоставлена данная карточка.")
                        .font(.custom("SF Pro Display Regular", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    Image("howBonuses")
                    
                    Text("Нажмите на нее, выберите, сколько бонусов вы хотите потратить, и сохраните. Приятного пользования!")
                        .font(.custom("SF Pro Display Regular", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    Text("История")
                        .font(.custom("SF Pro Display Bold", size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    ScrollView {
                        ForEach(history.sorted(by: { $0.date < $1.date })) { order in
                            HStack {
                                VStack{
                                    Text("Начислили за заказ")
                                        .font(.custom("SF Pro Display Regular", size: 20))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(formatDate(order.date)) // Date
                                        .font(.custom("SF Pro Display Regular", size: 15))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 3)
                                }
                                Spacer()
                                Text("+" + String(Double(order.totalPrice) * 0.1))
                                    .font(.custom("SF Pro Display Regular", size: 20))
                            }
                            .padding(.vertical, 5)
                        }
                        Text("Всё, записей больше нет")
                            .font(.custom("SF Pro Display Regular", size: 20))
                            .padding(.bottom, 30)
                    }
                    .padding(.top, 10)
                }
                .foregroundColor(.white)
                .padding()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
