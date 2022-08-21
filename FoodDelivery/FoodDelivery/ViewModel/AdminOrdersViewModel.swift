//
//  AdminOrdersViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 14.08.2022.
//

import Foundation

// MARK: - AdminOrdersViewModel class

class AdminOrdersViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var orders = [Order]()
    
    // MARK: - Public methods
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        AuthService.shared.signOut()
    }
}
