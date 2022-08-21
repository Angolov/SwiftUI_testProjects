//
//  ProductCategory.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 21.08.2022.
//

import Foundation

// MARK: - ProductCategory enum

enum ProductCategory: String {
    
    case pizza
    case burger
    case sushi
    case kebab
    case donut
    case iceCream
    case coffee
    case notSpecified
    
    // MARK: = Properties
    
    var categoryName: String {
        switch self {
        case .pizza:
            return "Пицца"
        case .burger:
            return "Бургеры"
        case .sushi:
            return "Суши"
        case .kebab:
            return "Шаурма"
        case .donut:
            return "Пончики"
        case .iceCream:
            return "Мороженое"
        case .coffee:
            return "Кофе и чай"
        case .notSpecified:
            return ""
        }
    }
    
    // MARK: - Public methods
    
    static func getCategoryFromString(_ string: String) -> ProductCategory? {
        switch string {
        case pizza.rawValue:
            return ProductCategory.pizza
        case burger.rawValue:
            return ProductCategory.burger
        case sushi.rawValue:
            return ProductCategory.sushi
        case kebab.rawValue:
            return ProductCategory.kebab
        case donut.rawValue:
            return ProductCategory.donut
        case iceCream.rawValue:
            return ProductCategory.iceCream
        case coffee.rawValue:
            return ProductCategory.coffee
        default:
            return nil
        }
    }
}
