//
//  CafeInfoView.swift
//  Bites
//
//  Created by Диас Сайынов on 09.05.2024.
//

import SwiftUI

struct CafeInfoView: View {
    var selectedCafe: CafeAddress
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ChooseOptionViewModel()

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
                    Text("Bites, \(selectedCafe.name)")
                        .font(.custom("SF-Pro-Display-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical)
                    Text("Большой ассортимент")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("ул. \(selectedCafe.name)")
                        .font(.custom("SF-Pro-Display-Bold", size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    Text("Пн - Пт: \(selectedCafe.weekDayTime)")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    Text("Сб - Вс: \(selectedCafe.weekEndTime)")
                        .font(.custom("SF-Pro-Display-Bold", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    MyCustomButton(title: "Указать номер столика", action: {
                        print("")
                    }, isActive: true)
                    .padding(.bottom, 40)
                }
                .background(.white)
                .cornerRadius(10)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
