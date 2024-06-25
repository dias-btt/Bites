//
//  ProductService.swift
//  Bites
//
//  Created by Диас Сайынов on 14.05.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProductService {
    private let db = Firestore.firestore()

    private func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }

    func fetchProducts() async throws -> [Product] {
        let productsCollectionRef = db.collection("products")

        let querySnapshot = try await productsCollectionRef.getDocuments()
        
        return querySnapshot.documents.compactMap { document in
            do {
                // Attempt to decode the document into a Product struct
                let product = try document.data(as: Product.self)
                return product
            } catch {
                print("Error decoding product:", error)
                return nil
            }
        }
    }
}
