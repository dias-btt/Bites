//
//  OrderViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 14.05.2024.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [OrderResult] = []
    @Published var currentOrder: OrderResult?
    @Published var products: [Product] = []
    let deliveryService = DeliveryService()
    
    init() {
        fetchOrders()
        setCurrentOrder()
        fetchProductsOnInit()
    }
    
    func fetchOrders() {
        Task {
            do {
                let orders = try await deliveryService.fetchOrders()
                DispatchQueue.main.async {
                    self.orders = orders
                }
            } catch {
                // Handle error
                print("Error fetching orders: \(error)")
            }
        }
    }
    
    func fetchOrderById(orderId: String) async throws -> [Product]? {
        do {
            // Use the delivery service to fetch the order by ID
            let order = try await deliveryService.fetchOrderByResultId(orderResultId: orderId)
            guard let keys = order?[0].products.keys else {return nil}
            return Array(keys)
        } catch {
            // Handle errors
            print("Error fetching order by ID: \(error)")
            return nil
        }
    }
        
    func setCurrentOrder() {
        Task{
            do{
                let currentOrder = try await deliveryService.getCurrentOrder()
                DispatchQueue.main.async {
                    self.currentOrder = currentOrder
                }
            } catch {
                print("Error fetching current order: \(error)")
            }
        }
    }
        
    func fetchProductsOnInit() {
        Task {
            do {
                let productIds = self.currentOrder?.productIds ?? []
                let products = try await fetchProducts(by: productIds)
                DispatchQueue.main.async {
                    self.products = products
                }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }
        
    func fetchProducts(by ids: [String]) async throws -> [Product] {
        return try await deliveryService.fetchProducts(forProductIds: ids)
    }
}
