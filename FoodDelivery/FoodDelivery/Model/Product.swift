//
//  Product.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import Foundation

// MARK: - Product struct

struct Product {
    
    // MARK: - Properties
    
    var id: String
    var title: String
    var imageUrl: String
    var image: Data
    var price: Int
    var description: String
//    var ordersCount: Int
//    var isRecommended: Bool
    
    init(id: String,
         title: String,
         imageUrl: String = "",
         image: Data = Data(),
         price: Int,
         description: String) {
        
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.image = image
        self.price = price
        self.description = description
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["decription"] = self.description
        return repres
    }
}
