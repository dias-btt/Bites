//
//  AddressView.swift
//  Bites
//
//  Created by Диас Сайынов on 03.05.2024.
//
import SwiftUI

struct AddressesView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedAddress: Address? // Binding to track the selected address
    @State private var viewModel = AddressesViewModel()
    var addresses: [Address]?
    @State private var editingAddress: Address?
    
    var body: some View {
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
                
                Text("Адреса доставки")
                    .font(.custom("SF-Pro-Display-Bold", size: 34))
                
                Spacer()
            }
            .padding()

            VStack {
                ForEach(viewModel.addresses) { address in
                    HStack{
                        AddressView(selectedAddress: $selectedAddress, address: address)
                        Button {
                            editingAddress = address
                        } label: {
                            Image("edit")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    
                }
            }
            .padding()
            
            Spacer()

            NavigationLink(destination: AddAddressView().navigationBarBackButtonHidden(true)) {
                HStack {
                    Image(systemName: "plus")
                        .padding()
                    Text("Добавить новый адрес")
                        .font(.custom("SF-Pro-Display-Bold", size: 17))
                        .padding()
                }
                .background(Color("Primary"))
                .cornerRadius(20)
                .padding()
                .foregroundColor(.white)
            }
            NavigationLink(
                destination: EditAddressView(address: editingAddress ?? Address(streetNhome: "", entrance: "", code: "", floor: "", apartmentNumber: "", comments: "")).navigationBarBackButtonHidden(true),
                isActive: Binding(  // Binding to control navigation
                    get: { editingAddress != nil },
                    set: { if !$0 { editingAddress = nil } }
                )
            ) {
                EmptyView()  // Invisible, used for navigation control
            }
        }
    }
}

#Preview {
    AddressesView(selectedAddress: .constant(nil))
}
