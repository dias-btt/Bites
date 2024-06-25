//
//  ProductView.swift
//  Bites
//
//  Created by Диас Сайынов on 09.04.2024.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    @State private var isFavorite = false
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack {
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 157, height: 120)
                .cornerRadius(8)

            Text(product.name)
                .font(.custom("SF Pro Display Regular", fixedSize: 15))
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(product.price)₸")
                .font(.custom("SF Pro Display Medium", fixedSize: 15))
                .foregroundColor(.black)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button(action: {
                    isFavorite.toggle()
                    if isFavorite {

                    } else {

                    }
                }) {
                    Image(isFavorite ? "heart.fill" : "heart")
                        .frame(width: 30, height: 30)
                        .background(Color("NavBack"))
                        .cornerRadius(6)
                }

                Spacer()

                Button(action: {
                    onAddToCart()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color("Primary"))
                        .cornerRadius(6)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.vertical, 8)
        .frame(width: 190, height: 240)
    }
}


