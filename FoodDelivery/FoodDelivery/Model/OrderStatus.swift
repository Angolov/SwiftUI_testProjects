//
//  OrderStatus.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation

enum OrderStatus: String {
    
    case new = "Новый"
    case cooking = "Готовиться"
    case inDelivery = "Доставляется"
    case completed = "Выполнен"
    case cancelled = "Отменен"
}
