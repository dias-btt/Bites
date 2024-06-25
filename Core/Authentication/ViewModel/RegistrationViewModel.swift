//
//  RegistrationViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject{
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var birthDate: Date = Date()
    @Published var country = ""
    @Published var city = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, name: name, birthDate: birthDate, country: country, city: city)
        
        username = ""
        email = ""
        password = ""
        name = ""
        birthDate = Date()
        country = ""
        city = ""
    }
}
