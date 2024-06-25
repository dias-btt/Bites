//
//  ProfileViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 03.05.2024.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var orders: [OrderResult] = []
    let deliveryService = DeliveryService()
    
    init(){
        fetchOrders()
    }
    
    func signOut() async throws{
        AuthService.shared.signout()
    }
    
    func deleteUser() async throws {
        try await AuthService.shared.deleteAccount()
    }
    
    func fetchOrders() {
        Task {
            do {
                self.orders = try await deliveryService.fetchOrders()
            } catch {
                // Handle error
                print("Error fetching orders: \(error)")
            }
        }
    }
}
