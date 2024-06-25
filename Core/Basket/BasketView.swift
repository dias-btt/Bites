//
//  BasketView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.04.2024.
//

import SwiftUI
import CoreLocation

struct BasketView: View {
    let products: [Product]
    var option: Option
    let user: User
    let selectedCafeAddress: CafeAddress
    let fromTab: Bool
    @State private var selectedProducts: [Product: Int] = [:]
    @StateObject private var basketViewModel = BasketViewModel()
    @State private var isPickupOrderViewActive = false
    @State private var isDeliveryViewActive = false
    @Environment(\.presentationMode) var presentationMode
    
    var totalPrice: Int {
        selectedProducts.reduce(0) { sum, item in
            let (product, quantity) = item
            return sum + (product.price * quantity)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if products.isEmpty{
                    Spacer()
                    Image("empty")
                        .resizable()
                        .frame(width: 380, height: 380)
                    Text("Пока тут пусто")
                        .font(.custom("SF Pro Display Bold", size: 30))
                        .foregroundColor(Color("Primary"))
                    Text("Добавьте печеньки, кофе или другие вкусности, чтобы сделать свой день еще лучше!")
                        .font(.custom("SF Pro Display Medium", size: 20))
                        .foregroundColor(Color("Primary"))
                        .padding(.horizontal, 20)
                        .padding(.top, 5)
                        .multilineTextAlignment(.center)
                    Spacer()
                    if !fromTab{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                            Text("Перейти в меню")
                                .font(.custom("SF Pro Display Bold", size: 17))
                                .foregroundColor(.white)
                                .padding()
                                .padding(.horizontal, 100)
                                .background(Color("Primary"))
                                .cornerRadius(20)
                        }
                    }
                }
                else{
                    ForEach(products) { product in
                        let quantityBinding = Binding(
                            get: { selectedProducts[product] ?? 0 },
                            set: { newQuantity in
                                selectedProducts[product] = newQuantity
                            }
                        )
                        
                        BasketCellView(
                            isChecked: Binding(
                                get: { self.selectedProducts.keys.contains(product) },
                                set: { isChecked in
                                    if isChecked {
                                        selectedProducts[product] = 1
                                    } else {
                                        selectedProducts.removeValue(forKey: product)
                                    }
                                }
                            ),
                            quantity: quantityBinding,
                            productName: product.name,
                            productImage: product.imageName,
                            category: product.category,
                            price: product.price
                        )
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    
                    if option == .delivery{
                        NavigationLink(
                            destination: DeliveryView(products: selectedProducts, totalPrice: totalPrice, user: user).navigationBarBackButtonHidden(true),
                            isActive: $isDeliveryViewActive
                        ) {
                            MyCustomButton(
                                title: "Оформить заказ на \(totalPrice) ₸",
                                action: {isDeliveryViewActive = true},
                                isActive: totalPrice > 0
                            )
                        }
                    } else {
                        MyCustomButton(title: "Оформить заказ на \(totalPrice) ₸", action: {
                            let id = UUID().uuidString
                            let date = Date()
                            let products = selectedProducts
                            let totalPrice = totalPrice
                            let bonusesUsed = 0
                            let newBonuses = Int(Double(totalPrice) * 0.1)
                            let order = PickupOrder(id: id,
                                                    date: date,
                                                    products: products,
                                                    totalPrice: Double(totalPrice),
                                                    cafeAddress: selectedCafeAddress,
                                                    completed: false,
                                                    bonusesUsed: bonusesUsed)
                            
                            Task {
                                await basketViewModel.createOrder(order: order)
                                await basketViewModel.updateBonuses(addedBonus: newBonuses)
                            }
                            isPickupOrderViewActive = true
                        }, isActive: totalPrice > 0)
                        
                        NavigationLink(destination: TrackingView(option: option, cafeAddress: selectedCafeAddress).navigationBarBackButtonHidden(true),
                                       isActive: $isPickupOrderViewActive) {
                            EmptyView()
                        }
                    }
                }
            }
            .padding()
        }
    }
}
