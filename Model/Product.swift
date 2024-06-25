//
//  Product.swift
//  Bites
//
//  Created by Диас Сайынов on 09.04.2024.
//

import Foundation

struct Product: Identifiable, Hashable, Codable {
    let id: String
    let category: String
    let name: String
    let imageName: String
    let price: Int
    let mass: Int
    let description: String
    let composition: String
    let rating: Float

    init(id: String, category: String, name: String, imageName: String, price: Int, mass: Int, description: String, composition: String, rating: Float) {
        self.id = id
        self.category = category
        self.name = name
        self.imageName = imageName
        self.price = price
        self.mass = mass
        self.description = description
        self.composition = composition
        self.rating = rating
    }
}

