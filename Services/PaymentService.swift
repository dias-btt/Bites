//
//  PaymentService.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class PaymentService {
    private let db = Firestore.firestore()

    // Function to get the current user's ID
    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    // Function to save card information in Firestore
    func addCard(card: Card) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        // Reference to the user's payment collection
        let userPaymentsRef = db.collection("users").document(userId).collection("payments")

        // Save card information
        let cardData: [String: Any] = [
            "cardnum": card.cardnum,
            "expirationDate": card.expirationDate,
            "securityCode": card.securityCode
        ]

        // Add card to the Firestore collection
        try await userPaymentsRef.addDocument(data: cardData)
    }
    
    func fetchCards() async throws -> [Card] {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let userPaymentsRef = db.collection("users").document(userId).collection("payments")
        
        let querySnapshot = try await userPaymentsRef.getDocuments()
        return querySnapshot.documents.compactMap { doc in
            guard
                let cardnum = doc.data()["cardnum"] as? String,
                let expirationDate = doc.data()["expirationDate"] as? String,
                let securityCode = doc.data()["securityCode"] as? String
            else {
                return nil
            }
            
            return Card(cardnum: cardnum, expirationDate: expirationDate, securityCode: securityCode)
        }
    }
}
