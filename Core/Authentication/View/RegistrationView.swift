//
//  RegistrationView.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var confirmPassword = ""
    @State private var isNextViewActive = false
    @State private var isDisabled = true
    @State private var isEmailValid = true
    
    var body: some View {
        NavigationView {
            VStack {
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
                    
                    Text("Создать профиль")
                        .font(.custom("SF Pro Display Bold", size: 34))
                    
                    Spacer()
                }
                
                CustomTextField(label: "Почта или номер", text: $viewModel.email, keyboardType: .emailAddress, isValid: isValidEmail(viewModel.email))
                    .onChange(of: viewModel.email) { _ in
                        updateButtonState()
                    }
                                    
                CustomSecureField(label: "Пароль", text: $viewModel.password)
                    .onChange(of: viewModel.password) { _ in
                        updateButtonState()
                    }
                
                CustomSecureField(label: "Повторите пароль", text: $confirmPassword)
                    .onChange(of: confirmPassword) { _ in
                        updateButtonState()
                    }

                Spacer()
                
                CustomButtonView(action: {
                    isNextViewActive = true
                }, label: "Продолжить", isDisabled: isDisabled)

                NavigationLink(destination: ChooseCountryView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(viewModel), isActive: $isNextViewActive) {
                    EmptyView()
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
    
    private func updateButtonState() {
        isDisabled = viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.password != confirmPassword || viewModel.password.count < 6
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
