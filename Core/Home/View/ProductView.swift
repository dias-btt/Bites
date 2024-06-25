//
//  ProductView.swift
//  Bites
//
//  Created by Диас Сайынов on 17.04.2024.
//

import SwiftUI
import CoreLocation

struct ProductView: View {
    @State private var quantity: Int = 1
    @State private var currentBasketProducts: Int = 0
    let product: Product
    let option: Option
    let user: User
    let hits = ["Хит", "Новинка"]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()

                    NavigationLink(destination: FavouritesView()) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color("Primary"))
                            .frame(width: 30, height: 30)
                            .background(Color("NavBack"))
                            .cornerRadius(6)
                    }
                    
                    NavigationLink(destination: BasketView(products: [product], option: .delivery, user: user, selectedCafeAddress: CafeAddress(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), weekDayTime: "", weekEndTime: ""), fromTab: false).navigationBarBackButtonHidden(true)) {
                        ZStack{
                            Image(systemName: "cart.fill")
                                .foregroundColor(Color("Primary"))
                                .frame(width: 30, height: 30)
                                .background(Color("NavBack"))
                                .cornerRadius(6)
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                                .overlay(
                                    Text("\(currentBasketProducts)")
                                        .foregroundColor(Color("Tertiary"))
                                        .font(.system(size: 10, weight: .bold))
                                )
                                .offset(x: 6, y: -6)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                
                //Image
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 390, height: 290)
                    .padding(.horizontal)
                
                //Hit or Novinki
                HStack{
                    ForEach(hits.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("NavBack"))
                            .frame(width: 112, height: 38)
                            .overlay(
                                Text(hits[index])
                                    .foregroundColor( Color("Primary"))
                                    .font(.headline)
                                    .padding()
                            )
                    }
                    Spacer()
                    NavigationLink(destination: FavouritesView()) {
                        Image(systemName: "heart")
                            .foregroundColor(Color("Primary"))
                            .frame(width: 30, height: 30)
                            .background(Color("NavBack"))
                            .cornerRadius(6)
                    }
                }
                .padding(.horizontal)
                
                //Name and rating
                HStack{
                    Text(product.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("SF Pro Display Medium", size: 24))
                    HStack{
                        Image("star")
                            .frame(width: 18, height: 18)
                        Text(String(format: "%.1f", product.rating))
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .padding()
                
                //mass
                Text("\(product.mass) г")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("SF Pro Display Regular", size: 16))
                    .padding(.horizontal)
                    .padding(.top, -15)
                    .foregroundColor(Color("Tertiary"))
                
                //price
                Text("\(product.price) ₸")
                    .font(.custom("SF Pro Display Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                //description
                Text(product.description)
                    .font(.custom("SF Pro Display Regular", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .foregroundColor(.gray)

                //composition
                Text(product.composition)
                    .font(.custom("SF Pro Display Regular", size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
                //Quantity and add to basket button
                HStack{
                    HStack {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Image(systemName: "minus")
                                .padding()
                                .foregroundColor(Color("Primary"))
                                .frame(width: 30, height: 30)
                                .background(Color("NavBack"))
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)
                        
                        Text("\(quantity)")
                            .font(.headline)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .foregroundColor(Color("Primary"))
                                .frame(width: 30, height: 30)
                                .background(Color("NavBack"))
                                .cornerRadius(6)
                        }
                        .padding(.horizontal)

                    }
                                    
                    Button(action: {
                        currentBasketProducts = quantity
                    }) {
                        Text("Добавить в корзину")
                            .font(.custom("SF Pro Display Bold", size: 17))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Primary"))
                            .cornerRadius(20)
                    }
                    .padding()
                }
            }
        }
    }
}
