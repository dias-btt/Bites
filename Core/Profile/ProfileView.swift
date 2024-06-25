//
//  ProfileView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.04.2024.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    @State private var showLogoutSheet: Bool = false  // Controls when the sheet is shown
    @State private var showDeleteAlert: Bool = false
    @State private var showBonusesView: Bool = false

    @State private var navigateToMyData: Bool = false
    @State private var navigateToPayment: Bool = false
    @State private var viewModel = ProfileViewModel()
    @State private var showNotifications: Bool = false

    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    //hello message
                    Text("Привет, \(user.name)")
                        .font(.custom("SF Pro Display Bold", size: 24))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    //horizontal scroll view
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            //bonuses
                            Button{
                                showBonusesView = true
                            } label: {
                                ZStack{
                                    VStack{
                                        HStack{
                                            VStack{
                                                Text("Бонусы")
                                                    .font(.custom("SF Pro Display Medium", size: 18))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundStyle(Color.black)
                                                Text("\(user.bonuses)")
                                                    .font(.custom("SF Pro Display Medium", size: 18))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundStyle(Color.black)
                                            }
                                            Image("cookies")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 60, height: 60)
                                        }
                                        Spacer()
                                        Text("Нажмите, чтобы потратить")
                                            .font(.custom("SF Pro Display Regular", size: 11))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(Color("Tertiary"))
                                    }
                                    .padding()
                                }
                                .background(Color("Profile"))
                                .cornerRadius(20)
                            }
                            
                            //my orders
                            NavigationLink(destination: MyOrdersView(user: user).navigationBarBackButtonHidden(true)){
                                ZStack{
                                    HStack{
                                        VStack{
                                            Text("Мои заказы")
                                                .font(.custom("SF Pro Display Medium", size: 18))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(Color.black)
                                            Spacer()
                                            Text("1 активный")
                                                .font(.custom("SF Pro Display Regular", size: 11))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(Color("Tertiary"))
                                            
                                        }
                                        .padding()
                                    }
                                }
                                .background(Color("Profile"))
                                .cornerRadius(20)
                            }
                            
                            //address
                            NavigationLink(destination: AddressesView(selectedAddress: .constant(nil)).navigationBarBackButtonHidden(true))
                            {
                                ZStack{
                                    HStack{
                                        VStack{
                                            Text("Адреса доставки")
                                                .font(.custom("SF Pro Display Medium", size: 18))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundStyle(Color.black)
                                            Spacer()
                                            Text("1 адрес")
                                                .font(.custom("SF Pro Display Regular", size: 11))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(Color("Tertiary"))
                                            
                                        }
                                        .padding()
                                    }
                                }
                                .background(Color("Profile"))
                                .cornerRadius(20)
                            }
                        }
                        .frame(height: 123)
                    }
                    .padding()
                }
                .background(Color("Primary"))
                Spacer()
                //buttons
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        NavigationLink(
                            destination: MyDataView().navigationBarBackButtonHidden(true),
                                isActive: $navigateToMyData,
                                label: {
                                    ButtonView(
                                        iconName: "prof-btn-1",
                                        title: "Мои данные",
                                        action: {
                                            navigateToMyData = true
                                        }
                                )
                            }
                        )
                        
                        NavigationLink(
                            destination: PaymentMethodView(selectedPaymentMethod: .constant(nil)).navigationBarBackButtonHidden(true),
                                isActive: $navigateToPayment,
                                label: {
                                    ButtonView(
                                        iconName: "prof-btn-2",
                                        title: "Способы оплаты",
                                        action: {
                                            navigateToPayment = true
                                        }
                                )
                            }
                        )
                        
                        ButtonView(iconName: "prof-btn-3", title: "Уведомления о скидках", action: {
                            showNotifications.toggle()
                        }, showToggle: true)
                        
                        VStack {
                            ButtonView(iconName: "prof-btn-5", title: "Выйти", action: {
                                showLogoutSheet = true
                            })
                            
                            ButtonView(iconName: "prof-btn-6", title: "Удалить профиль", action: {
                                showDeleteAlert = true
                            })
                        }
                        .padding(.top, 40)
                    }
                    .background(.white)
                    .cornerRadius(20)
                }
                .padding(.top, 40)
                .cornerRadius(20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        }
        .actionSheet(isPresented: $showLogoutSheet) {
            ActionSheet(
                title: Text("Вы действительно хотите выйти?"),
                message: nil,
                buttons: [
                    .destructive(Text("Выйти"), action: {
                        Task { try await viewModel.signOut() }
                    }),
                    .cancel(Text("Отмена"))
                ]
            )
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Удалить профиль?"),
                message: Text("""
                    Это займет 10 дней. Мы удалим:
                    - Ваши личные данные,
                    - Сохраненные адреса,
                    - Историю заказов,
                    - Накопленные бонусы
                """),
                primaryButton: .destructive(Text("Удалить"), action: {
                    Task {try await viewModel.deleteUser()}
                }),
                secondaryButton: .cancel(Text("Отмена"))
            )
        }
        .sheet(isPresented: $showBonusesView) {
            BonusesView(bonuses: user.bonuses, history: viewModel.orders)
        }

    }
}
