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
    
    var messageTitle = ""
    var messageText = ""
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
    
    func placeOrder(completion: @escaping () -> Void) {
        let order = Order(userID: SessionManager.shared.userID,
                          positions: positions,
                          status: .new)
        
        DatabaseService.shared.setOrder(order: order) { [weak self] result in
            switch result {
            case .success(let order):
                self?.messageTitle = "Спасибо"
                self?.messageText = "Ваш заказ на сумму \(order.cost) ₽ создан!"
                self?.positions = [Position]()
                
            case .failure(let error):
                self?.messageTitle = "Ошибка!"
                self?.messageText = "\(error.localizedDescription)"
            }
            completion()
        }
    }
}
