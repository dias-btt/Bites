//
//  BasketService.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct BasketService {
    private let db = Firestore.firestore()

    // Fetch the current user's ID from Firebase Authentication
    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    // Add a product to the current user's "currentBasket" sub-collection
    func addProductToCurrentBasket(product: Product) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        // Reference to the user's "currentBasket" sub-collection
        let basketRef = db.collection("users").document(userId).collection("currentBasket")

        // Data to add to Firestore
        let productData: [String: Any] = [
            "category": product.category,
            "composition": product.composition,
            "description": product.description,
            "imageName": product.imageName,
            "mass": product.mass,
            "name": product.name,
            "price": product.price,
            "rating": product.rating,
            "addedAt": Timestamp(date: Date())
        ]

        // Add the product to the "currentBasket"
        try await basketRef.addDocument(data: productData)
    }
}
