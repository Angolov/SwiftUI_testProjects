//
//  OrderStatus.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation

// MARK: - OrderStatus enum

enum OrderStatus: String {
    
    case new = "Новый"
    case cooking = "Готовиться"
    case inDelivery = "Доставляется"
    case completed = "Выполнен"
    case cancelled = "Отменен"
    
    static func getStatusFromString(_ string: String) -> OrderStatus? {
        switch string {
        case new.rawValue:
            return OrderStatus.new
        case cooking.rawValue:
            return OrderStatus.cooking
        case inDelivery.rawValue:
            return OrderStatus.inDelivery
        case completed.rawValue:
            return OrderStatus.completed
        case cancelled.rawValue:
            return OrderStatus.cancelled
        default:
            return nil
        }
    }
}
