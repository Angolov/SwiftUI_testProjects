//
//  AdminOrderViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 14.08.2022.
//

import Foundation

// MARK: - AdminOrderViewModel class

class AdminOrderViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var order: Order
    @Published var user = AppUser(id: "", name: "", phone: 0, address: "")
    
    // MARK: - Init
    
    init(order: Order) {
        self.order = order
        
        getUserProfile()
        getOrderPositions()
    }
    
    // MARK: - Private methods
    
    private func getUserProfile() {
        DatabaseService.shared.getUserProfile(by: order.userID) { result in
            switch result {
                
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getOrderPositions() {
        DatabaseService.shared.getPositions(for: order.id) { [weak self] result in
            switch result {
            case .success(let positions):
                self?.order.positions = positions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
