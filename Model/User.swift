//
//  User.swift
//  Bites
//
//  Created by Диас Сайынов on 01.04.2024.
//
import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: String
    let email: String
    let name: String
    let birthDate: Date
    var country: String
    var city: String
    var bonuses: Int
    
    init(id: String, email: String, name: String, birthDate: Date, country: String, city: String, bonuses: Int) {
        self.id = id
        self.email = email
        self.name = name
        self.birthDate = birthDate
        self.country = country
        self.city = city
        self.bonuses = bonuses
    }
}
