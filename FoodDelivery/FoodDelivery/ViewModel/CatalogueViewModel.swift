//
//  CatalogueViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import Foundation
import UIKit

// MARK: - CatalogueViewModel class

class CatalogueViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var popularProducts = [Product]()
    @Published var allProducts = [Product]()
    
    init() {
        hardcodeProducts()
        saveHardcodedProducts()
    }
    
    func getProducts() {
        DatabaseService.shared.getProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.allProducts = products
                for (index, product) in products.enumerated() {
                    StorageService.shared.downloadProductImage(id: product.id) { result in
                        switch result {
                            
                        case .success(let data):
                            self.allProducts[index].image = data
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
    
    func getPopularProducts() {
        var products = [Product]()
        for product in allProducts {
            if product.isRecommended {
                products.append(product)
            }
        }
        popularProducts = products
    }
    
    private func getImages() {
        
    }
}

// MARK: Hardcoding products base

extension CatalogueViewModel {
    
    func hardcodeProducts() {
        
        guard let image = UIImage(named: "PizzaMargarita"),
              let imageData = image.jpegData(compressionQuality: 0.15) else { return }
        
        let hardcodedProducts = [
            Product(id: "1",
                    title: "Пицца Маргарита",
                    image: imageData,
                    price: 450,
                    description: "Самая простая пицца",
                    category: .pizza,
                    isRecommended: true),
            Product(id: "2",
                    title: "Пицца Пепперони",
                    image: imageData,
                    price: 550,
                    description: "Самая простая пицца",
                    category: .pizza,
                    isRecommended: true),
            Product(id: "3",
                    title: "Пицца Гавайская",
                    image: imageData,
                    price: 400,
                    description: "Самая простая пицца",
                    category: .pizza,
                    isRecommended: false),
            Product(id: "4",
                    title: "Пицца Диабло",
                    image: imageData,
                    price: 620,
                    description: "Самая простая пицца",
                    category: .pizza,
                    isRecommended: false),
            Product(id: "5",
                    title: "Пицца Деревенская",
                    image: imageData,
                    price: 620,
                    description: "Самая простая пицца",
                    category: .pizza,
                    isRecommended: false)
        ]
        
        self.allProducts = hardcodedProducts
        getPopularProducts()
    }
    
    func saveHardcodedProducts() {
        
        for product in allProducts {
            DatabaseService.shared.setProduct(product: product) { result in
                switch result {
                case .success(let product):
                    print("\(product.title) saved")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
