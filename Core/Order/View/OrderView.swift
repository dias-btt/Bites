//
//  OrderView.swift
//  Bites
//
//  Created by Диас Сайынов on 29.04.2024.
//

import SwiftUI
import CoreLocation

func formattedDateInRussian(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU") // Russian locale
    dateFormatter.dateFormat = "d MMMM yyyy г. в HH:mm" // Date and time format
    return dateFormatter.string(from: date)
}

struct OrderView: View {
    let order: OrderResult
    @State private var orderToBasket: [Product]?
    let user: User
    @State private var viewModel = OrderViewModel()
    @State private var isBasketViewActive = false

    var body: some View {
        
        VStack{
            Text("№\(String(order.id.suffix(4)))")
                .font(.custom("SF Pro Display Bold", size: 20))
                .foregroundColor(Color("Primary"))
            Text("\(formattedDateInRussian(date: Date()))")
                .font(.custom("SF Pro Display Regular", size: 15))
            Text("На доставку: \(order.address.streetNhome)")
                .font(.custom("SF Pro Display Regular", size: 15))
            
            ForEach(viewModel.products) { (product) in
                HStack{
                    Image("mindal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 115, height: 77)
                        .cornerRadius(8)
                        .padding(.vertical)
                        .padding(.leading, -10)
                    VStack{
                        Text(product.category)
                            .font(.custom("SF Pro Display Regular", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(product.name)
                            .font(.custom("SF Pro Display Regular", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            HStack{
                Text("Всего")
                    .font(.custom("SF Pro Display Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Primary"))
                Spacer()
                Text("\(order.totalPrice) ₸")
                    .font(.custom("SF Pro Display Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color("Primary"))
            }
            .padding()
            
            NavigationLink(
                destination: BasketView(products: orderToBasket ?? [], option: .delivery, user: user, selectedCafeAddress: CafeAddress(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), weekDayTime: "", weekEndTime: ""), fromTab: false),
                    isActive: $isBasketViewActive,
                    label: {
                        MyCustomButton(title: "Повторить заказ", action: {
                            isBasketViewActive = true
                        }, isActive: true)
                    }
                )
                .padding()
        }
        .padding()
        .cornerRadius(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("Forth"))
        )
        .onAppear {
            Task {
                do {
                    viewModel.products = try await viewModel.fetchProducts(by: order.productIds)
                    //orderToBasket = try await viewModel.fetchOrderById(orderId: order.id)
                } catch {
                    print("Error fetching products: \(error)")
                }
            }
        }
    }
}
