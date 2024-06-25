//
//  PickupService.swift
//  Bites
//
//  Created by Диас Сайынов on 17.05.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class PickupService {
    private let db = Firestore.firestore()

    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func createPickupOrder(order: PickupOrder) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        let userOrderRef = db.collection("users").document(userId).collection("pickupOrders")
        
        let productIds = order.products.keys.map { $0.id }
        let quantities = Array(order.products.values)

        let orderData: [String: Any] = [
            "id": order.id,
            "date": order.date,
            "productIds": productIds,
            "quantities": quantities,
            "totalPrice": order.totalPrice,
            "cafeAddress": [
                "name": order.cafeAddress.name,
                "coordinate": GeoPoint(latitude: order.cafeAddress.coordinate.latitude, longitude: order.cafeAddress.coordinate.longitude),
                "weekDayTime": order.cafeAddress.weekDayTime,
                "weekEndTime": order.cafeAddress.weekEndTime
            ],
            "completed": order.completed,
            "bonusesUser": order.bonusesUsed
        ]

        try await userOrderRef.addDocument(data: orderData)
    }
    
    func updateBonuses(addedBonus: Int) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userDocumentRef = db.collection("users").document(userId)
        
        let userSnapshot = try await userDocumentRef.getDocument()
        guard var userData = userSnapshot.data() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
        }
        
        var currentBonuses = userData["bonuses"] as? Int ?? 0
        
        currentBonuses += addedBonus
        
        // Update the bonuses field in the user document
        userData["bonuses"] = currentBonuses
        try await userDocumentRef.setData(userData)
    }
}
