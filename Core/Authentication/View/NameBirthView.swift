//
//  NameBirthView.swift
//  Bites
//
//  Created by Диас Сайынов on 02.04.2024.
//

import SwiftUI

struct NameBirthView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack{
            Text("Давайте познакомимся!")
                .font(.custom("SF Pro Display Bold", size: 34))
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CustomTextField(label: "Введите свое имя", text: $viewModel.name, keyboardType: .namePhonePad)
            CustomDateField(label: "Дата рождения", date: $viewModel.birthDate)
            
            Text("Важно! Мы дарим скидки и подарки в день рождения. К сожалению, день рождения нельзя изменить.")
                .font(.custom("SF Pro Display Regular", size: 15))
                .padding(.top)
                .foregroundColor(Color("Tertiary"))
            
            Spacer()
            
            CustomButtonView(action: {
                Task {
                    do {
                        try await viewModel.createUser()
                    } catch {
                        errorMessage = error.localizedDescription
                        showErrorAlert = true
                    }
                }
            }, label: "Готово", isDisabled: viewModel.name.isEmpty)
            .padding()
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NameBirthView()
}
