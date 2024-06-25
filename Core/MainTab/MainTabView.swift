//
//  MainTabView.swift
//  Bites
//
//  Created by Диас Сайынов on 03.04.2024.
//
import SwiftUI
import CoreLocation

struct MainTabView: View {
    
    enum Tab: String {
        case home = "Меню"
        case basket = "Корзина"
        case contact = "Контакты"
        case profile = "Профиль"
    }
    
    let user: User?
    @State private var selectedIndex: Tab = .home
    @State private var selectedProducts: [Product] = []
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex){
                // HomeView tab
                HomeView(user: user!, selectedProducts: $selectedProducts)
                    .tabItem {
                        VStack {
                            Image(selectedIndex == .home ? "tab1-s" : "tab1")
                            Text(Tab.home.rawValue)
                                .font(.custom("SF-Pro-Display-Regular", size: 12))
                        }
                    }
                    .tag(Tab.home)
                    .onTapGesture {
                        if selectedIndex == .home {
                            selectedIndex = .home
                        }
                    }
                
                // BasketView tab
                BasketView(products: selectedProducts, option: .delivery, user: user!, selectedCafeAddress: CafeAddress(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), weekDayTime: "", weekEndTime: ""), fromTab: true)
                    .tabItem {
                        Image(selectedIndex == .basket ? "tab2-s" : "tab2")
                        Text(Tab.basket.rawValue)
                            .font(.custom("SF-Pro-Display-Regular", size: 12))
                    }
                    .tag(Tab.basket)
                
                // ContactsView tab
                ContactsView()
                    .tabItem {
                        Image(selectedIndex == .contact ? "tab3-s" : "tab3")
                        Text(Tab.contact.rawValue)
                            .font(.custom("SF-Pro-Display-Regular", size: 12))
                    }
                    .tag(Tab.contact)
                
                // ProfileView tab
                ProfileView(user: user!)
                    .tabItem {
                        Image(selectedIndex == .profile ? "tab4-s" : "tab4")
                        Text(Tab.profile.rawValue)
                            .font(.custom("SF-Pro-Display-Regular", size: 12))
                    }
                    .tag(Tab.profile)
            }
            .accentColor(Color("Primary"))
        }
    }
}
