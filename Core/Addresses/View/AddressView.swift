//
//  AddressesView.swift
//  Bites
//
//  Created by Диас Сайынов on 27.04.2024.
//
import SwiftUI

struct AddressView: View {
    @Binding var selectedAddress: Address? // Binding for the selected address
    let address: Address
    
    var isCheck: Bool {
        selectedAddress == address // Check if this address is selected
    }
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Button {
                    selectedAddress = address // Set the selected address
                    print(address)
                } label: {
                    Image(isCheck ? "check" : "uncheck") // Change image based on selection
                }
                
                VStack {
                    Text(address.streetNhome)
                        .font(.custom("SF-Pro-Display-Bold", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("кв \(address.apartmentNumber), \(address.entrance) подъезд, \(address.floor) этаж.")
                        .font(.custom("SF-Pro-Display-Regular", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }                
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    AddressView(selectedAddress: .constant(nil), address: Address(
        streetNhome: "Майлина, 41",
        entrance: "7",
        code: "1234",
        floor: "9",
        apartmentNumber: "149", comments: ""
    ))
}
