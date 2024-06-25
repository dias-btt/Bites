//
//  Contact.swift
//  Bites
//
//  Created by Диас Сайынов on 03.05.2024.
//

import Foundation

struct Contact: Identifiable{
    let id = UUID()
    let image: String
    let address: String
    let workingTime: String
    let phone: String
}

let contacts = [
    Contact(image: "contact1", address: "Центральный парк", workingTime: "9:00 - 22:00", phone: "8 (775) 999-87-55"),
    Contact(image: "contact2", address: "Тауелсиздик, 12", workingTime: "9:00 - 22:00", phone: "8 (775) 999-87-55"),
    Contact(image: "contact3", address: "Бейбитшилик, 39", workingTime: "9:00 - 22:00", phone: "8 (775) 999-87-55"),
    Contact(image: "contact4", address: "Калдаякова, 12", workingTime: "9:00 - 22:00", phone: "8 (775) 999-87-55"),
]
