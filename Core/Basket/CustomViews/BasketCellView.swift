//
//  BasketCellView.swift
//  Bites
//
//  Created by Диас Сайынов on 19.04.2024.
//

import SwiftUI

struct BasketCellView: View {
    @Binding var isChecked: Bool
    @Binding var quantity: Int

    let productName: String
    let productImage: String
    let category: String
    let price: Int

    var totalPrice: Int {
        return price * quantity
    }
    
    var body: some View {
        HStack{
            Button {
                isChecked.toggle()
            } label: {
                Image(isChecked ? "check" : "uncheck")
                    .frame(width: 31, height: 31)
            }
            .padding(.horizontal)

            Image(productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 115, height: 77)
                .cornerRadius(8)
                .padding(.vertical)
                .padding(.leading, -10)
            
            VStack {
                Text(category)
                    .font(.custom("SF Pro Display Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(productName)
                    .font(.custom("SF Pro Display Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Button(action: {
                        if quantity > 1 {
                            quantity -= 1
                        }
                    }) {
                        Image(systemName: "minus")
                            .padding()
                            .foregroundColor(Color("NavBackDark"))
                            .frame(width: 30, height: 30)
                            .background(Color("NavBack"))
                            .cornerRadius(6)
                    }
                    
                    Text("\(quantity)")
                        .font(.custom("SF Pro Display Medium", size: 17))
                        .foregroundColor(Color("NavBackDark"))
                    
                    Button(action: {
                        quantity += 1
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(Color("NavBackDark"))
                            .frame(width: 30, height: 30)
                            .background(Color("NavBack"))
                            .cornerRadius(6)
                    }
                    
                    Text("\(totalPrice) ₸")
                        .font(.custom("SF Pro Display Bold", size: 17))

                }

            }
        }
        .background(Color("NavBackLight"))
        .cornerRadius(20)
    }
}
