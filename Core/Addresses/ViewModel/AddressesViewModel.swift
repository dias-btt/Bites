//
//  AddressesViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 08.05.2024.
//
import Foundation
import Combine

class AddressesViewModel: ObservableObject {
    private let addressesService = AddressesService() // Instance of the payment service
    @Published var addresses: [Address] = []
    
    init() {
        Task {
            await loadAddresses()
        }
    }
    
    func loadAddresses() async {
        do {
            let fetchedAddresses = try await addressesService.fetchAddresses()
            DispatchQueue.main.async {
                self.addresses = fetchedAddresses
            }
        } catch {
            print("Error fetching addresses:", error.localizedDescription) // Handle error
        }
    }
    
    // Function to save address information
    func saveAddress(address: Address) async {
        do {
            try await addressesService.addAddress(address: address)
        } catch {
            print("Error saving address:", error.localizedDescription) // Handle errors appropriately
        }
    }
    
    // Function to update address info
    func updateAddress(address: Address) async {
        do {
            try await addressesService.updateAddress(address: address)  // Update the address
            await loadAddresses()  // Refresh the list
        } catch {
            print("Error updating address: \(error)")
        }
    }
}

