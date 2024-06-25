//
//  DeliveryService.swift
//  Bites
//
//  Created by Диас Сайынов on 12.05.2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DeliveryService {
    private let db = Firestore.firestore()

    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func fetchOrders() async throws -> [OrderResult] {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userOrdersRef = db.collection("users").document(userId).collection("orders")
        
        let querySnapshot = try await userOrdersRef.getDocuments()
        
        return try querySnapshot.documents.compactMap { document in
            let order = try document.data(as: OrderResult.self)
            return order
        }
    }
    
    func getCurrentOrder() async throws -> OrderResult? {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userOrderRef = db.collection("users").document(userId).collection("orders")
        
        let querySnapshot = try await userOrderRef.order(by: "date", descending: true).limit(to: 1).getDocuments()
        
        guard let document = querySnapshot.documents.first else {
            // No orders found, return nil
            return nil
        }
        
        let order = try document.data(as: OrderResult.self)
        return order
    }

    
    func updateBonuses(addedBonus: Int, usedBonus: Int) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userDocumentRef = db.collection("users").document(userId)
        
        let userSnapshot = try await userDocumentRef.getDocument()
        guard var userData = userSnapshot.data() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User data not found"])
        }
        
        var currentBonuses = userData["bonuses"] as? Int ?? 0
        
        currentBonuses = currentBonuses + addedBonus - usedBonus
        
        // Update the bonuses field in the user document
        userData["bonuses"] = currentBonuses
        try await userDocumentRef.setData(userData)
    }

    func createOrder(order: Order) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        let userOrderRef = db.collection("users").document(userId).collection("orders")
        
        let productIds = order.products.keys.map { $0.id }
        let quantities = Array(order.products.values)

        let orderData: [String: Any] = [
            "id": order.id,
            "date": order.date,
            "address": [
                "streetNhome": order.address.streetNhome,
                "entrance": order.address.entrance,
                "code": order.address.code,
                "floor": order.address.floor,
                "apartmentNumber": order.address.apartmentNumber,
                "comments": order.address.comments
            ],
            "productIds": productIds,
            "quantities": quantities,
            "totalPrice": order.totalPrice,
            "deliveryTime": order.deliveryTime,
            "noContact": order.noContact,
            "courierComments": order.courierComments,
            "restaurantComments": order.restaurantComments,
            "bonusesUsed": order.bonusesUsed
        ]

        try await userOrderRef.addDocument(data: orderData)
    }
    
    func updateOrder(order: Order, orderId: String) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userOrderRef = db.collection("users").document(userId).collection("currentOrder").document(orderId)
        
        let productIds = order.products.keys.map { $0.id }
        let quantities = Array(order.products.values)

        let orderData: [String: Any] = [
            "id": order.id,
            "date": order.date,
            "address": [
                "streetNhome": order.address.streetNhome,
                "entrance": order.address.entrance,
                "code": order.address.code,
                "floor": order.address.floor,
                "apartmentNumber": order.address.apartmentNumber,
                "comments": order.address.comments
            ],
            "productIds": productIds,
            "quantities": quantities,
            "totalPrice": order.totalPrice,
            "deliveryTime": order.deliveryTime,
            "noContact": order.noContact,
            "courierComments": order.courierComments,
            "restaurantComments": order.restaurantComments,
            "bonusesUsed": order.bonusesUsed
        ]
        
        try await userOrderRef.setData(orderData, merge: true)
    }
    
    func fetchProducts(forProductIds productIds: [String]) async throws -> [Product] {
        var products: [Product] = []
        
        for productId in productIds {
            let productRef = db.collection("products").document(productId)
            
            let documentSnapshot = try await productRef.getDocument()
            if let productData = documentSnapshot.data() {
                do {
                    if let product = try? Firestore.Decoder().decode(Product.self, from: productData) {
                        products.append(product)
                    }
                } catch {
                    print("Error decoding product: \(error)")
                }
            }
        }
        
        return products
    }
    
    func fetchOrderByResultId(orderResultId: String) async throws -> [Order]? {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userOrdersRef = db.collection("users").document(userId).collection("orders")
        let query = userOrdersRef.whereField("id", isEqualTo: orderResultId)
        
        let querySnapshot = try await query.getDocuments()
        
        return querySnapshot.documents.compactMap { document in
            do {
                // Attempt to decode the document into a Product struct
                let order = try document.data(as: Order.self)
                return order
            } catch {
                print("Error decoding product:", error)
                return nil
            }
        }
    }
}
