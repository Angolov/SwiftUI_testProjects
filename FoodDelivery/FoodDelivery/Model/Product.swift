//
//  Product.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import Foundation
import FirebaseFirestore

// MARK: - Product struct

struct Product {
    
    // MARK: - Properties
    
    var id: String
    var title: String
    var image: Data
    var price: Int
    var description: String
    var category: ProductCategory
    var ordersCount: Int
    var isRecommended: Bool
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["decription"] = self.description
        repres["category"] = self.category.rawValue
        repres["ordersCount"] = self.ordersCount
        repres["isRecommended"] = self.isRecommended
        return repres
    }
    
    // MARK: Init
    
    init(id: String,
         title: String,
         image: Data = Data(),
         price: Int,
         description: String,
         category: ProductCategory = ProductCategory.notSpecified,
         ordersCount: Int = 0,
         isRecommended: Bool = false) {
        
        self.id = id
        self.title = title
        self.image = image
        self.price = price
        self.description = description
        self.category = category
        self.ordersCount = ordersCount
        self.isRecommended = isRecommended
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String,
              let title = data["title"] as? String,
              let price = data["price"] as? Int,
              let description = data["decription"] as? String,
              let categoryString = data["category"] as? String,
              let category = ProductCategory.getCategoryFromString(categoryString),
              let ordersCount = data["ordersCount"] as? Int,
              let isRecommended = data["isRecommended"] as? Bool
        else { return nil }
        
        self.init(id: id,
                  title: title,
                  price: price,
                  description: description,
                  category: category,
                  ordersCount: ordersCount,
                  isRecommended: isRecommended)
    }
}
