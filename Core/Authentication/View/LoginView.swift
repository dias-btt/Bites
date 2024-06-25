//
//  LoginView.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import SwiftUI

struct PrimaryToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                configuration.label
                    .foregroundColor(Color("Primary"))
                Spacer()
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(Color("Primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()

    @State private var rememberMe: Bool = false
    @State private var isDisabled: Bool = true
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing: 10){
                    Text("Войти")
                        .font(.custom("SF Pro Display Bold", size: 34))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Text("Новый пользователь?")
                            .font(.custom("SF Pro Display Regular", size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink {
                            // Navigate to registration
                            RegistrationView()
                                .navigationBarBackButtonHidden(true)
                                .environmentObject(registrationViewModel)
                        } label: {
                            Text("Создать аккаунт")
                                .foregroundColor(Color("Secondary"))
                                .font(.custom("SF Pro Display Regular", size: 20))
                        }
                    }
                }
                .padding(.top, 20)
                VStack{
                    //email and password fields
                    CustomTextField(label: "Почта или номер", text: $viewModel.email, keyboardType: .emailAddress)
                        .onReceive(viewModel.$email) { _ in
                            updateButtonState()
                        }
                    
                    CustomSecureField(label: "Пароль", text: $viewModel.password)
                        .onReceive(viewModel.$password) { _ in
                            updateButtonState()
                        }
                    
                    //buttons below password
                    HStack{
                        Toggle(isOn: $rememberMe) {
                            // Empty view for now
                        }
                        .frame(width: 50)

                        Text("Запомнить меня")
                            .font(.custom("SF Pro Display Regular", size: 18))
                            .foregroundColor(Color("Secondary"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 5)

                        Button(action: {
                            // Navigate to forget password
                        }, label: {
                            Text("Забыли пароль?")
                                .font(.custom("SF Pro Display Regular", size: 18))
                                .foregroundColor(Color("Secondary"))
                        })
                    }
                    .padding(.top, 10)
                    
                    //login button
                    CustomButtonView(action: {
                        Task { try await viewModel.signIn() }
                    }, label: "Войти", isDisabled: isDisabled)

                    Spacer()
                                        
                    //login with apple, google, facebook
                    VStack {
                        HStack{
                            Text("-")
                                .foregroundColor(Color("Tertiary"))
                            Text("или")
                                .font(.custom("SF Pro Display Regular", size: 20))
                                .foregroundColor(Color.black)
                            Text("-")
                                .foregroundColor(Color("Tertiary"))
                        }
                        .padding(.vertical, 30)
                        
                        Button(action: {
                            // Action for Sign in with Apple
                        }, label: {
                            HStack {
                                Image(systemName: "applelogo")
                                    .foregroundColor(Color.white)
                                Text("Войти через Apple")
                                    .foregroundColor(Color.white)
                                    .font(.custom("SF Pro Display Regular", size: 18))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(20)
                        })

                        Button(action: {
                            viewModel.signInGoogle()
                        }, label: {
                            HStack {
                                Image("Google")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                Text("Войти через Google")
                                    .foregroundColor(Color.black)
                                    .font(.custom("SF Pro Display Regular", size: 18))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        })
                        
                        Button(action: {
                            // Action for Google
                        }, label: {
                            HStack {
                                Image("facebook")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                Text("Войти через Facebook")
                                    .foregroundColor(Color.white)
                                    .font(.custom("SF Pro Display Regular", size: 18))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(20)
                        })
                    }

                }
            }
            .padding(.horizontal)
        }
    }
    
    private func updateButtonState() {
        isDisabled = viewModel.email.isEmpty || viewModel.password.isEmpty
    }
}

#Preview {
    LoginView()
}
