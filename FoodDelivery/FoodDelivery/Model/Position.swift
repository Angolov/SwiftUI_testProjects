//
//  Position.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 09.08.2022.
//

import Foundation
import FirebaseFirestore

struct Position: Identifiable {
    var id: String
    var product: Product
    var count: Int
    
    var cost: Int {
        return product.price * self.count
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = self.cost        
        return repres
    }
    
    init(id: String, product: Product, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String,
              let title = data["title"] as? String,
              let price = data["price"] as? Int,
              let count = data["count"] as? Int else { return nil }
        let product = Product(id: "", title: title, imageUrl: "", price: price, description: "")
        
        self.id = id
        self.product = product
        self.count = count
    }
}
