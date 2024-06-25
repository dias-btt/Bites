//
//  DeliveryView.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import SwiftUI

struct DeliveryView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var deliveryViewModel = DeliveryViewModel()
    @State private var isConfirmOrderViewActive = false

    let products: [Product: Int] 
    let totalPrice: Int
    let user: User
    
    @State private var showAddCommentModal = false
    @State private var commentSubtitle = "Особые запросы, аллергии, ограничения по диете?"
    
    @State private var addressTitle = "Выберите адрес"
    @State private var addressSubtitle = ""
    @State private var selectedAddress: Address?
    
    @State private var showTimeModal = false
    @State private var timeSubtitle = "Расстояние доставки: 1,2 км"
    @State private var isDeliveryEarlier = true
    @State private var selectedDeliveryTime = Date()

    @State private var isNoContact = false
    
    @State private var showAddCourierCommentModal = false
    @State private var commentCourierSubtitle = "Контактный номер и прочее"
    
    @State private var paymentTitle = "Выберите способ оплаты"
    @State private var paymentSubtitle = "У вас пока нету привязанных карт"
    @State private var selectedPaymentMethod: PaymentMethod?
        
    @State private var showBonusesModal = false // State for modal presentation
    @State private var bonusesSubtitle = ""

    var body: some View {
        NavigationView {
                VStack {
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss() // Back button
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color("Primary"))
                                    .frame(width: 28, height: 28)
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                            }
                        }
                        Text("Доставка")
                            .font(.custom("SF-Pro-Display-Bold", size: 34))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Button {
                        showAddCommentModal = true
                        print(products)
                    } label: {
                        DeliveryOptionCell(
                            title: .constant("Добавить комментарий для ресторана"),
                            subtitle: $commentSubtitle,
                            iconName: "comment"
                        )
                    }
                    
                    NavigationLink {
                        AddressesView(selectedAddress: $selectedAddress).navigationBarBackButtonHidden(true)
                    } label: {
                        DeliveryOptionCell(
                            title: .constant(addressTitle),
                            subtitle: $addressSubtitle,
                            iconName: "address"
                        )
                    }
                    
                    Button {
                        showTimeModal = true
                    } label: {
                        DeliveryOptionCell(
                            title: .constant(isDeliveryEarlier ? "Доставка через 30-40 мин" : "Доставка в \(timeFormatter().string(from: selectedDeliveryTime))"),
                            subtitle: $timeSubtitle,
                            iconName: "time"
                        )
                    }
                    
                    DeliveryToggleCell(
                        title: "Бесконтактная доставка",
                        subtitle: "Пожалуйста, оставьте мой заказ у двери",
                        iconName: "nocontact",
                        isToggled: $isNoContact // Pass the toggle binding
                    )
                    
                    Button {
                        showAddCourierCommentModal = true
                    } label: {
                        DeliveryOptionCell(
                            title: .constant("Добавить комментарий для курьера"),
                            subtitle: $commentCourierSubtitle,
                            iconName: "comment"
                        )
                    }
                    
                    Text("Оплата")
                        .font(.custom("SF-Pro-Display-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 15)
                        .padding(.horizontal)
                    
                    NavigationLink {
                        PaymentMethodView(selectedPaymentMethod: $selectedPaymentMethod).navigationBarBackButtonHidden(true)
                    } label: {
                        DeliveryOptionCell(
                                title: .constant("Выберите способ оплаты"),
                                subtitle: .constant((selectedPaymentMethod == nil)
                                                    ? "Выберите способ оплаты" : (selectedPaymentMethod == .cash) ? "Наличные" : (selectedPaymentMethod == .applePay) ? "ApplePay" : ""),
                                iconName: ""
                        )
                    }
                    
                    Button {
                        showBonusesModal = true
                    } label: {
                        DeliveryOptionCell(
                            title: .constant("Использовать бонусы"),
                            subtitle: .constant((user.bonuses > 0) ? "У вас \(user.bonuses) бонусов" : "У вас пока нету бонусов"),
                            iconName: ""
                        )
                    }
                    
                    Spacer()
                    MyCustomButton(title: "Оформить заказ", action: {
                        let id = UUID().uuidString
                        let date = Date()
                        let address = selectedAddress
                        let products = products
                        let totalPrice = totalPrice
                        let deliveryTime = selectedDeliveryTime
                        let noContact = isNoContact
                        let courierComments = commentCourierSubtitle
                        let restaurantComments = commentSubtitle
                        let bonusesUsed = Int(bonusesSubtitle)
                        let newBonuses = Int(Double(totalPrice) * 0.1)
                        let order = Order(
                            id: id,
                            date: date,
                            address: address!,
                            products: products,
                            totalPrice: totalPrice,
                            deliveryTime: deliveryTime,
                            noContact: noContact,
                            courierComments: courierComments,
                            restaurantComments: restaurantComments,
                            bonusesUsed: bonusesUsed ?? 0
                        )

                        Task {
                            await deliveryViewModel.createOrder(order: order)
                            await deliveryViewModel.updateCurrentOrder(order: order)
                            await deliveryViewModel.updateBonuses(addedBonus: newBonuses, usedBonus: bonusesUsed ?? 0)
                        }
                        isConfirmOrderViewActive = true
                    }, isActive: true)
                    NavigationLink(
                        destination: ConfirmOrderView().navigationBarBackButtonHidden(true),
                        isActive: $isConfirmOrderViewActive,
                        label: {
                            EmptyView()
                        }
                    )
                    Spacer()
                }
                .sheet(isPresented: $showAddCommentModal) { // Modal presentation
                    AddCommentModalView(commentText: $commentSubtitle)
                }
                .sheet(isPresented: $showAddCourierCommentModal) { // Modal presentation
                    AddCourierCommentModalView(commentText: $commentCourierSubtitle)
                }
                .sheet(isPresented: $showTimeModal) { // Modal presentation
                    ChooseDeliveryTimeModalView(
                        isEarlier: $isDeliveryEarlier, // Pass the boolean binding
                        selectedTime: $selectedDeliveryTime // Pass the time binding
                    )
                }
                .onChange(of: selectedAddress) { address in
                    if let address = address {
                        addressTitle = address.streetNhome
                        addressSubtitle = "кв \(address.apartmentNumber), \(address.entrance) подъезд, \(address.floor) этаж."
                    }
                }
                .sheet(isPresented: $showBonusesModal) { // Modal presentation
                    SpendBonusesModalView(bonuses: user.bonuses, commentText: $bonusesSubtitle)
                }
        }
    }
}

func timeFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}
