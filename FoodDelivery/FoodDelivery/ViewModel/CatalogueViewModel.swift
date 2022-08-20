//
//  CatalogueViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import Foundation

// MARK: - CatalogueViewModel class

class CatalogueViewModel: ObservableObject {
    
    // MARK: - Properties
    
    static let shared = CatalogueViewModel()
    
    var products = [
        Product(id: "1",
                title: "Пицца Маргарита",
                imageUrl: "PizzaMargarita",
                price: 450,
                description: "Самая простая пицца"),
        Product(id: "2",
                title: "Пицца Пепперони",
                imageUrl: "PizzaMargarita",
                price: 550,
                description: "Самая простая пицца"),
        Product(id: "3",
                title: "Пицца Гавайская",
                imageUrl: "PizzaMargarita",
                price: 400,
                description: "Самая простая пицца"),
        Product(id: "4",
                title: "Пицца Диабло",
                imageUrl: "PizzaMargarita",
                price: 620,
                description: "Самая простая пицца"),
        Product(id: "5",
                title: "Пицца Деревенская",
                imageUrl: "PizzaMargarita",
                price: 620,
                description: "Самая простая пицца")
    ]
    
    @Published var pizzas = [
        Product(id: "1",
                title: "Пицца Маргарита",
                imageUrl: "PizzaMargarita",
                price: 450,
                description: "Самая простая пицца"),
        Product(id: "2",
                title: "Пицца Пепперони",
                imageUrl: "PizzaMargarita",
                price: 550,
                description: "Самая простая пицца"),
        Product(id: "3",
                title: "Пицца Гавайская",
                imageUrl: "PizzaMargarita",
                price: 400,
                description: "Самая простая пицца"),
        Product(id: "4",
                title: "Пицца Диабло",
                imageUrl: "PizzaMargarita",
                price: 620,
                description: "Самая простая пицца"),
        Product(id: "5",
                title: "Пицца Деревенская",
                imageUrl: "PizzaMargarita",
                price: 620,
                description: "Самая простая пицца")
    ]
    
    func getProducts() {
        DatabaseService.shared.getProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.pizzas = products
                for (index, product) in products.enumerated() {
                    StorageService.shared.downloadProductImage(id: product.id) { result in
                        switch result {
                            
                        case .success(let data):
                            self.pizzas[index].image = data
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getImages() {
        
    }
}
