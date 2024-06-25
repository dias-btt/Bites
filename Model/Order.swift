//
//  Order.swift
//  Bites
//
//  Created by Диас Сайынов on 29.04.2024.
//

import Foundation

struct Order: Hashable, Codable, Identifiable{
    let id: String
    let date: Date
    let address: Address
    let products: [Product: Int]
    let totalPrice: Int
    let deliveryTime: Date
    let noContact: Bool
    let courierComments: String
    let restaurantComments: String
    let bonusesUsed: Int
    
    init(id: String, date: Date, address: Address, products: [Product: Int], totalPrice: Int, deliveryTime: Date, noContact: Bool, courierComments: String, restaurantComments: String, bonusesUsed: Int) {
        self.id = id
        self.date = date
        self.address = address
        self.products = products
        self.totalPrice = totalPrice
        self.deliveryTime = deliveryTime
        self.noContact = noContact
        self.courierComments = courierComments
        self.restaurantComments = restaurantComments
        self.bonusesUsed = bonusesUsed
    }
}

struct OrderResult: Hashable, Codable, Identifiable {
    let id: String
    let date: Date // Assuming date is stored as String
    let address: AddressResult
    let productIds: [String]
    let quantities: [Int]
    let totalPrice: Int
    let deliveryTime: Date // Assuming deliveryTime is stored as String
    let noContact: Bool
    let courierComments: String
    let restaurantComments: String
    let bonusesUsed: Int
}

struct AddressResult: Hashable, Codable {
    let streetNhome: String
    let entrance: String
    let code: String
    let floor: String
    let apartmentNumber: String
    let comments: String
}

struct PickupOrder {
    let id: String
    let date: Date
    let products: [Product: Int]
    let totalPrice: Double
    let cafeAddress: CafeAddress
    let completed: Bool
    let bonusesUsed: Int
    
    init(id: String, date: Date, products: [Product: Int], totalPrice: Double, cafeAddress: CafeAddress, completed:  Bool, bonusesUsed: Int) {
        self.id = id
        self.date = date
        self.products = products
        self.totalPrice = totalPrice
        self.cafeAddress = cafeAddress
        self.completed = completed
        self.bonusesUsed = bonusesUsed
    }
}

struct PickupOrderResult {
    let id: String
    let date: Date
    let productIds: [String]
    let quantities: [Int]
    let totalPrice: Double
    let cafeAddress: CafeAddress
    let completed: Bool
}
