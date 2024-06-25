//
//  PaymentViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 05.05.2024.
//

import Foundation
import Combine

class PaymentsViewModel: ObservableObject {
    private let paymentService = PaymentService() // Instance of the payment service
    @Published var cards: [Card] = []
    
    init() {
        Task {
            await loadCards()
        }
    }
    
    func loadCards() async {
        do {
            let fetchedCards = try await paymentService.fetchCards()
            DispatchQueue.main.async {
                self.cards = fetchedCards
            }
        } catch {
            print("Error fetching cards:", error.localizedDescription) // Handle error
        }
    }
    
    // Function to save card information
    func saveCard(card: Card) async {
        do {
            try await paymentService.addCard(card: card)
        } catch {
            print("Error saving card:", error.localizedDescription) // Handle errors appropriately
        }
    }
}
