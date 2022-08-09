//
//  Position.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 09.08.2022.
//

import Foundation

struct Position {
    var id: String
    var product: Product
    var count: Int
    
    var cost: Int {
        return product.price * self.count
    }
}
