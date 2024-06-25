//
//  TableCafeView.swift
//  Bites
//
//  Created by Диас Сайынов on 09.05.2024.
//

import SwiftUI

struct TableCafeView: View {
    @Binding var isCafeSelected: Bool
    @Binding var selectedCafe: CafeAddress?
    @Binding var isTableSelected: Bool
    let cafeAddresses: [CafeAddress]
    @StateObject var viewModel: ChooseOptionViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var tableNumber: String
    var dismissAction: (() -> Void)?
    
    var body: some View {
        if (!isCafeSelected && !isTableSelected){
            Spacer(minLength: 300)
            VStack{
                HStack{
                    Button {
                        dismissAction?()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    Button(action: {
                        //live location
                        viewModel.navigateToUserLocation()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "location.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                ZStack{
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                    VStack{
                        Text("Выберите кондитерскую")
                            .font(.custom("SF Pro Display Bold", size: 24))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        Text("Меню и доступные кондитерские могут отличаться в зависимости от локации")
                            .font(.custom("SF Pro Display Regular", size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        ScrollView {
                            ForEach(cafeAddresses){cafe in
                                Rectangle()
                                    .frame(height: 1)
                                    .padding()
                                Button {
                                    isCafeSelected = true
                                    selectedCafe = cafe
                                } label: {
                                    HStack{
                                        VStack{
                                            Text(cafe.name)
                                                .font(.custom("SF Pro Display Bold", size: 14))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text(cafe.weekDayTime)
                                                .font(.custom("SF Pro Display Regular", size: 14))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            Spacer(minLength: 30)
                        }
                    }
                    .background(.white)
                    .padding(.bottom, -5)
                }
            }
        }
        
        else if (isCafeSelected){
            Spacer(minLength: 300)
            VStack{
                HStack{
                    Button {
                        isCafeSelected = false
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    Button(action: {
                        //live location
                        viewModel.navigateToUserLocation()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 28, height: 28)
                            Image(systemName: "location.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                VStack{
                    Text("Bites, \(selectedCafe?.name ?? "")")
                        .font(.custom("SF-Pro-Display-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Text("Большой ассортимент")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("ул. \(selectedCafe?.name ?? "")")
                        .font(.custom("SF-Pro-Display-Bold", size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 15)
                    Text("Пн - Пт: \(selectedCafe?.weekDayTime ?? "")")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("Сб - Вс: \(selectedCafe?.weekEndTime ?? "")")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    MyCustomButton(title: "Указать номер столика", action: {
                        isTableSelected = true
                        isCafeSelected = false
                    }, isActive: true)
                    .padding(.bottom)
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.bottom, -5)
            }
        }
        
        else if (isTableSelected){
            Spacer(minLength: 300)
            VStack{
                Text("Введите номер, указанный на столе")
                    .font(.custom("SF-Pro-Display-Bold", size: 24))
                    .padding()
                    .multilineTextAlignment(.center)
                Text("Номер столика")
                    .font(.custom("SF Pro Display Regular", size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundStyle(Color.gray)
                TextField("", text: $tableNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .cornerRadius(15)
                //Spacer()
                MyCustomButton(title: "Сохранить", action: {
                    dismissAction?()
                }, isActive: true)
                .padding(.bottom, 40)
            }
            .background(.white)
            .cornerRadius(10)
            .padding(.bottom, -5)
        }
    }
}
