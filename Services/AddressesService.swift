//
//  AddressesService.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddressesService {
    private let db = Firestore.firestore()

    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func addAddress(address: Address) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        let userAddressesRef = db.collection("users").document(userId).collection("addresses")

        let addressData: [String: Any] = [
            "streetNhome": address.streetNhome,
            "entrance": address.entrance,
            "code": address.code,
            "floor": address.floor,
            "apartmentNumber": address.apartmentNumber,
            "comments": address.comments
        ]

        try await userAddressesRef.addDocument(data: addressData)
    }
    
    func updateAddress(address: Address) async throws {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        // Reference to the specific address document
        let userAddressDocRef = db.collection("users").document(userId).collection("addresses").document(address.id.uuidString)
        
        // Update the document with new data
        let updatedData: [String: Any] = [
            "streetNhome": address.streetNhome,
            "entrance": address.entrance,
            "code": address.code,
            "floor": address.floor,
            "apartmentNumber": address.apartmentNumber,
            "comments": address.comments
        ]
        
        try await userAddressDocRef.updateData(updatedData)  // Apply the update
    }

    func fetchAddresses() async throws -> [Address] {
        guard let userId = getCurrentUserId() else {
            throw NSError(domain: "User Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }

        let userAddressesRef = db.collection("users").document(userId).collection("addresses")

        // Fetch documents and convert to Address structs
        let querySnapshot = try await userAddressesRef.getDocuments()
        return querySnapshot.documents.compactMap { doc in
            guard
                let streetNhome = doc.data()["streetNhome"] as? String,
                let entrance = doc.data()["entrance"] as? String,
                let code = doc.data()["code"] as? String,
                let floor = doc.data()["floor"] as? String,
                let apartmentNumber = doc.data()["apartmentNumber"] as? String,
                let comments = doc.data()["comments"] as? String
            else {
                return Address(
                        streetNhome: "",
                        entrance: "",
                        code: "",
                        floor: "",
                        apartmentNumber: "",
                        comments: ""
                    )
            }

            // Create an Address instance from the fetched data
            return Address(
                streetNhome: streetNhome,
                entrance: entrance,
                code: code,
                floor: floor,
                apartmentNumber: apartmentNumber,
                comments: comments
            )
        }
    }
}
