//
//  Order.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation
import FirebaseFirestore

// MARK: - Order struct

struct Order {
    
    // MARK: - Properties
    
    var id = UUID().uuidString
    var userID: String
    var total = 0
    var date = Date()
    var status: OrderStatus
    
    var positions = [Position]() {
        didSet {
            if positions.count > 0 {
                var sum = 0
                
                for position in positions {
                    sum += position.cost
                }
                
                self.total = sum
            }
        }
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["total"] = total
        repres["date"] = Timestamp(date: date)
        repres["status"] = status.rawValue
        return repres
    }
    
    // MARK: - Init
    
    init(id: String = UUID().uuidString,
         userID: String,
         positions: [Position] = [Position](),
         date: Date = Date(),
         status: OrderStatus) {
        
        self.id = id
        self.userID = userID
        self.positions = positions
        self.date = date
        self.status = status
        
        if positions.count > 0 {
            var sum = 0
            
            for position in positions {
                sum += position.cost
            }
            
            self.total = sum
        }
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String,
              let userID = data["userID"] as? String,
              let total = data["total"] as? Int,
              let date = data["date"] as? Timestamp,
              let statusInString = data["status"] as? String,
              let orderStatus = OrderStatus.getStatusFromString(statusInString) else { return nil }
        
        self.id = id
        self.userID = userID
        self.total = total
        self.date = date.dateValue()
        self.status = orderStatus
    }
}
