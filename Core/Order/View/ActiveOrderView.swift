//
//  ActiveOrderView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//


import SwiftUI
import CoreLocation

struct ActiveOrderView: View {
    let order: OrderResult
    @State private var viewModel = OrderViewModel()
    @State private var isTrackingViewActive = false

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
                        /*
                        if (quantity > 1){
                            Text("x\(quantity)")
                                .font(.custom("SF-Pro-Display", size: 20))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                         */
                    }
                }
            }
            
            HStack{
                Text("Всего")
                    .font(.custom("SF Pro Display Regular", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Primary"))
                Spacer()
                Text("\(order.totalPrice) ₸")
                    .font(.custom("SF Pro Display Bold", size: 20))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color("Primary"))
            }
            .padding()
            
            NavigationLink(destination: TrackingView(option: .delivery, cafeAddress: CafeAddress(name: "Sample Cafe", coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), weekDayTime: "09:00 - 22:00", weekEndTime: "10:00 - 23:00")).navigationBarBackButtonHidden(true), isActive: $isTrackingViewActive) {
                MyCustomButton(title: "Отслеживать заказ", action: {
                    isTrackingViewActive = true
                }, isActive: true)
            }
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
                } catch {
                    print("Error fetching products: \(error)")
                }
            }
        }

    }
}
