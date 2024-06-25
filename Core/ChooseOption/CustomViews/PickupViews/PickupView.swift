//
//  PickupView.swift
//  Bites
//
//  Created by Диас Сайынов on 16.05.2024.
//


import SwiftUI

struct PickupView: View {
    @Binding var isCafeSelected: Bool
    @Binding var selectedCafe: CafeAddress?
    @State private var isConfirmationScreenPresented = false

    let cafeAddresses: [CafeAddress]
    @StateObject var viewModel: ChooseOptionViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var dismissAction: (() -> Void)?
    
    var body: some View {
        if (!isCafeSelected){
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
                                    isConfirmationScreenPresented.toggle()
                                } label: {
                                    HStack{
                                        VStack{
                                            Text(cafe.name)
                                                .font(.custom("SF Pro Display Medium", size: 14))
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
        
        if (isConfirmationScreenPresented){
            Spacer(minLength: 300)
            VStack{
                Text("Bites, \(selectedCafe?.name ?? "")")
                    .font(.custom("SF Pro Display Bold", size: 24))
                    .padding()
                    .multilineTextAlignment(.center)
                Text(selectedCafe?.name ?? "")
                    .font(.custom("SF Pro Display Bold", size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text(selectedCafe?.weekDayTime ?? "")
                    .font(.custom("SF Pro Display Regular", size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundStyle(Color.gray)
                //Spacer()
                MyCustomButton(title: "Заберу здесь", action: {
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
