//
//  ProfileViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: AppUser
    @Published var orders: [Order] = [Order]()
    
    init(profile: AppUser) {
        self.profile = profile
    }
    
    func setProfile() {
        DatabaseService.shared.setProfile(user: profile) { result in
            switch result {
                
            case .success(_):
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        DatabaseService.shared.getProfile { result in
            switch result {
                
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: SessionManager.shared.userID) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
