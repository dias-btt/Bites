//
//  EditAddressView.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//

import SwiftUI

struct EditAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var streetNhome: String = ""
    @State private var entrance: String = ""
    @State private var code: String = ""
    @State private var floor: String = ""
    @State private var apartmentNumber: String = ""
    @State private var comments: String = ""
    
    @State private var viewModel = AddressesViewModel()
    let address: Address
    
    init(address: Address) {
        self.address = address
        _streetNhome = State(initialValue: address.streetNhome)
        _entrance = State(initialValue: address.entrance)
        _code = State(initialValue: address.code)
        _floor = State(initialValue: address.floor)
        _apartmentNumber = State(initialValue: address.apartmentNumber)
        _comments = State(initialValue: address.comments)
    }

    var fieldsFilled: Bool {
        !streetNhome.isEmpty && !entrance.isEmpty && !code.isEmpty &&
        !floor.isEmpty && !apartmentNumber.isEmpty && !comments.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
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
                    
                    Text("Редактировать Адрес")
                        .font(.custom("SF-Pro-Display-Bold", size: 34))
                    
                    Spacer()
                }
                .padding()

                VStack {
                    LabelledTextField(label: "Street and House", text: $streetNhome)
                    LabelledTextField(label: "Entrance", text: $entrance)
                    LabelledTextField(label: "Code", text: $code)
                    LabelledTextField(label: "Floor", text: $floor)
                    LabelledTextField(label: "Apartment Number", text: $apartmentNumber)
                    LabelledTextField(label: "Comments", text: $comments)
                }
                .padding()

                Spacer()
                
                MyCustomButton(title: "Сохранить",
                               action: {
                    Task {
                        if fieldsFilled {
                            let updatedAddress = Address(
                                streetNhome: streetNhome,
                                entrance: entrance,
                                code: code,
                                floor: floor,
                                apartmentNumber: apartmentNumber,
                                comments: comments
                            )
                            await viewModel.updateAddress(address: updatedAddress)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                },
                isActive: fieldsFilled)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    EditAddressView(address: Address(
        streetNhome: "Майлина, 41",
        entrance: "7",
        code: "1234",
        floor: "9",
        apartmentNumber: "149",
        comments: "Close to the elevator"
    ))
}
