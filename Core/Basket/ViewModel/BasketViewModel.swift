//
//  BasketViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 31.05.2024.
//

import Foundation
import Combine

class BasketViewModel: ObservableObject {
    private let pickupService = PickupService()
    @Published var currentOrder: OrderResult?
    @Published var isLoading = false
    
    func createOrder(order: PickupOrder) async {
        do {
            try await pickupService.createPickupOrder(order: order)
        } catch {
            // Handle error
            print("Error creating order: \(error)")
        }
    }
    
    func updateBonuses(addedBonus: Int) async {
        do {
            try await pickupService.updateBonuses(addedBonus: addedBonus)
        } catch {
            // Handle error
            print("Error updating bonuses: \(error)")
        }
    }
}
