//
//  ProductViewModel.swift
//  Bites
//
//  Created by Диас Сайынов on 14.05.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var cookies: [Product] = []
    @Published var croissants: [Product] = []
    @Published var cakes: [Product] = []
    @Published var bread: [Product] = []
    @Published var coffee: [Product] = []
    @Published var tea: [Product] = []

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let productService = ProductService()

    func fetchProducts() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedProducts = try await productService.fetchProducts()
                separateProductsByCategory(products: fetchedProducts)
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }

    private func separateProductsByCategory(products: [Product]) {
        cookies = products.filter { $0.category == "Печенье" }
        croissants = products.filter { $0.category == "Круассаны" }
        cakes = products.filter { $0.category == "Пироги" }
        bread = products.filter { $0.category == "Хлеб" }
        tea = products.filter { $0.category == "Чай" }
        coffee = products.filter { $0.category == "Кофе" }
    }

    init() {
        fetchProducts()
    }
}
