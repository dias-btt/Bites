//
//  MyOrdersView.swift
//  Bites
//
//  Created by Диас Сайынов on 29.04.2024.
//

import SwiftUI

struct MyOrdersView: View {
    let user: User
    @Environment(\.presentationMode) var presentationMode
    @State private var viewModel = OrderViewModel()

    @State private var isActive: Bool = true
    @State private var isHistory: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                HStack{
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
                    
                    Text("Мои заказы")
                        .font(.custom("SF Pro Display Bold", size: 34))
                    
                    Spacer()
                }
                                
                HStack {
                    Button {
                        isActive = true
                        isHistory = false
                    } label: {
                        Text("Активные")
                            .font(.custom(isActive ? "SF Pro Display Bold" : "SF Pro Display Regular", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(isActive ? Color("Primary") : Color.clear)
                            .foregroundColor(isActive ? .white : Color("Primary"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Primary"), lineWidth: 1)
                            )
                    }
                    
                    Button {
                        isActive = false
                        isHistory = true
                    } label: {
                        Text("История")
                            .font(.custom(isHistory ? "SF Pro Display Bold" : "SF Pro Display Regular", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(isHistory ? Color("Primary") : Color.clear)
                            .foregroundColor(isHistory ? .white : Color("Primary"))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Primary"), lineWidth: 1)
                            )
                    }
                }
                .padding(.top, 20)
                
                if (isHistory){
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.orders, id: \.id) { order in
                                OrderView(order: order, user: user)
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                    }
                }
                
                if (isActive){
                    if let currentOrder = viewModel.currentOrder {
                        ActiveOrderView(order: currentOrder)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

