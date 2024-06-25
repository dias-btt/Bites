//
//  HomeView.swift
//  Bites
//
//  Created by Диас Сайынов on 03.04.2024.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State private var viewModel = ProductViewModel()
    let categories = ["Печенье", "Пироги", "Круассаны", "Хлеб", "Кофе", "Чай"]
    let user: User
    @State private var option: Option = .delivery
    
    @State private var isDelivery = true
    @State private var isPickup = false
    @State private var isTable = false
    @State private var tableNumber: String = ""
    
    @State private var selectedAddress: Address?
    @State private var selectedCafeAddress: CafeAddress?

    @State private var selectedIndex: Int? = 0
    @State private var selectedProduct: Product?
    
    @State private var currentBasketProducts: Int = 0
    @Binding var selectedProducts: [Product]

    var selectedCategoryProducts: [Product] {
        switch selectedIndex {
        case 0:
            return viewModel.cookies
        case 1:
            return viewModel.cakes
        case 2:
            return viewModel.croissants
        case 3:
            return viewModel.bread
        case 4:
            return viewModel.coffee
        case 5:
            return viewModel.tea
        default:
            return []
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                //Nav Bar here
                HStack {
                    NavigationLink {
                        ChooseOptionView(isDelivery: $isDelivery, isPickup: $isPickup, isTable: $isTable, tableNumber: $tableNumber, selectedAddress: $selectedAddress, selectedCafe: $selectedCafeAddress)
.navigationBarBackButtonHidden(true)
                    } label: {
                        HStack {
                            Text(isDelivery ? "Доставка \(selectedAddress?.streetNhome ?? "")" : (isPickup ? "Самовывоз" : "За столик (\(tableNumber))"))
                                .foregroundStyle(Color.black)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
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
                    
                    NavigationLink(destination: BasketView(products: selectedProducts, option: isDelivery ? .delivery : (isPickup ? .pickup : .table), user: user, selectedCafeAddress: selectedCafeAddress ?? CafeAddress(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), weekDayTime: "", weekEndTime: ""), fromTab: false).navigationBarBackButtonHidden(true)) {
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
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("NavBack"))
                            .frame(width: 110, height: 40)
                        
                        HStack {
                            Text("\(user.bonuses)")
                                .foregroundColor(.black)
                                .font(.headline)
                            Image("cookies")
                                .resizable()
                                .frame(width: 36, height: 36)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .padding()
                
                //Collection of categories
                HStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories.indices, id: \.self) { index in
                                CategoryCell(categoryText: categories[index], isSelected: index == selectedIndex)
                                    .onTapGesture {
                                        selectedIndex = index
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 32) {
                        ForEach(selectedCategoryProducts) { product in
                            NavigationLink(destination: ProductView(product: product, option: option, user: user).navigationBarBackButtonHidden(true)) {
                                ProductCell(product: product,
                                            onAddToCart: {
                                    selectedProducts.append(product)
                                    currentBasketProducts += 1
                                })
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}
