//
//  AdminAddProductViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 20.08.2022.
//

import Foundation

// MARK: - AdminAddProductError enum

enum AdminAddProductError: Error {
    case wrongPrice
    case noImageData
}

// MARK: - AdminAddProductViewModel class

class AdminAddProductViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var productTitle = ""
    @Published var productPrice: Int? = nil
    @Published var productDescript = ""
    @Published var productImageData = Data()
    
    // MARK: - Public methods
    
    func saveProductToDatabase(imageData: Data?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let productPrice = productPrice else {
            let error = AdminAddProductError.wrongPrice
            print("Ошибка! Неверно указана цена нового товара")
            completion(.failure(error))
            return
        }
        
        guard let imageData = imageData else {
            let error = AdminAddProductError.noImageData
            print("Ошибка! Не получены данные изображения нового товара")
            completion(.failure(error))
            return
        }

        let newProduct = Product(id: UUID().uuidString,
                                 title: productTitle,
                                 image: imageData,
                                 price: productPrice,
                                 description: productDescript)
        
        DatabaseService.shared.setProduct(product: newProduct) { result in
            switch result {
                
            case .success(let product):
                completion(.success("Product \(product.title) saved"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
