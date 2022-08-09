//
//  CartViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 09.08.2022.
//

import Foundation

class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    
    private init() {}
    
    @Published var positions = [Position]()
    
    var totalCost: Int {
        var total = 0
        
        for pos in positions {
            total += pos.cost
        }
        
        return total
    }
    
    func addPosition(_ position: Position) {
        
        self.positions.append(position)
    }
}
