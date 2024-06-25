//
//  DeliveryViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 12.05.2024.
//
import Foundation
import Combine

class DeliveryViewModel: ObservableObject {
    private let deliveryService = DeliveryService()
    @Published var currentOrder: OrderResult?
    @Published var isLoading = false
    
    func loadCurrentOrder() async {
        isLoading = true
        do {
            let order = try await deliveryService.getCurrentOrder()
            currentOrder = order
        } catch {
            // Handle error
            print("Error loading current order: \(error)")
        }
        isLoading = false
    }
    
    // Function to create a new order
    func createOrder(order: Order) async {
        do {
            try await deliveryService.createOrder(order: order)
        } catch {
            // Handle error
            print("Error creating order: \(error)")
        }
    }
    
    // Function to update the current order
    func updateCurrentOrder(order: Order) async {
        guard let currentOrderId = currentOrder?.id else {
            print("Current order ID is nil.")
            return
        }
        
        do {
            try await deliveryService.updateOrder(order: order, orderId: currentOrderId)
        } catch {
            // Handle error
            print("Error updating order: \(error)")
        }
    }
    
    func updateBonuses(addedBonus: Int, usedBonus: Int) async {
        do {
            // Call the delivery service to update bonuses
            try await deliveryService.updateBonuses(addedBonus: addedBonus, usedBonus: usedBonus)
        } catch {
            // Handle error
            print("Error updating bonuses: \(error)")
        }
    }
}
