//
//  Address.swift
//  Bites
//
//  Created by Диас Сайынов on 27.04.2024.
//

import Foundation

struct Address: Hashable, Codable, Identifiable {
    let id: UUID
    let streetNhome: String
    let entrance: String
    let code: String
    let floor: String
    let apartmentNumber: String
    let comments: String

    init(streetNhome: String, entrance: String, code: String, floor: String, apartmentNumber: String, comments: String) {
        self.id = UUID()
        self.streetNhome = streetNhome
        self.entrance = entrance
        self.code = code
        self.floor = floor
        self.apartmentNumber = apartmentNumber
        self.comments = comments
    }
}

let addresses = [
    Address(
        streetNhome: "Майлина, 41",
        entrance: "7",
        code: "1234",
        floor: "9",
        apartmentNumber: "149",
        comments: "Leave package at the door."
    ),
    Address(
        streetNhome: "Майлина, 41",
        entrance: "7",
        code: "1234",
        floor: "9",
        apartmentNumber: "149",
        comments: "Leave package at the door."
    ),
    Address(
        streetNhome: "Майлина, 41",
        entrance: "7",
        code: "1234",
        floor: "9",
        apartmentNumber: "149",
        comments: "Leave package at the door."
    )
]
