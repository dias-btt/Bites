//
//  DeliveryView.swift
//  Bites
//
//  Created by Диас Сайынов on 10.05.2024.
//

import SwiftUI

struct DeliveryOptionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: ChooseOptionViewModel
    @State private var addressesViewModel = AddressesViewModel()
    
    @Binding var isAddressSelected: Bool
    @Binding var selectedAddress: Address?
    var dismissAction: (() -> Void)?

    var body: some View {
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
                if (!addressesViewModel.addresses.isEmpty){
                    Text("Мои адреса")
                        .font(.custom("SF Pro Display Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    ScrollView {
                        ForEach(addressesViewModel.addresses) { address in
                            AddressView(selectedAddress: $selectedAddress, address: address)
                                .onTapGesture {
                                    if selectedAddress == address {
                                        selectedAddress = nil // Deselect if already selected
                                    } else {
                                        selectedAddress = address // Select the address
                                    }
                                }
                                .padding(.horizontal)
                        }
                        Spacer(minLength: 30)
                    }
                    
                } else {
                    Text("Здесь пока пусто")
                        .font(.custom("SF Pro Display Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    Text("Добавьте адрес, чтобы сделать заказ")
                        .font(.custom("SF Pro Display Medium", size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: AddAddressView().navigationBarBackButtonHidden(true)) {
                    HStack {
                        Image(systemName: "plus")
                            .padding()
                        Text("Добавить новый адрес")
                            .font(.custom("SF Pro Display Bold", size: 17))
                            .padding()
                    }
                    .background(Color("Primary"))
                    .cornerRadius(20)
                    .padding()
                    .foregroundColor(.white)
                }
            }
            .background(.white)
            .padding(.bottom, -5)
        }
    }
}
