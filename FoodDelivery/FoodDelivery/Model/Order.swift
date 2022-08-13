//
//  Order.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation
import FirebaseFirestore

struct Order {
    
    var id = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date = Date()
    var status: OrderStatus
    
    var cost: Int {
        var sum = 0
        
        for position in positions {
            sum += position.cost
        }
        
        return sum
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["status"] = status.rawValue
        return repres
    }
}
