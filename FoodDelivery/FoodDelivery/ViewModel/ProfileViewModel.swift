//
//  ProfileViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation

// MARK: - ProfileViewModel class

class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var profile: AppUser
    @Published var orders: [Order] = [Order]()
    
    // MARK: - Init
    
    init(profile: AppUser) {
        self.profile = profile
    }
    
    // MARK: - Public methods
    
    func setProfile() {
        let phonePattern = "+* (***) ***-**-**"
        let phoneNumber = profile.phone
        profile.phone = phoneNumber.applyPatternOnNumbers(pattern: phonePattern,
                                                          replacementCharacter: "*")
        
        DatabaseService.shared.setUserProfile(for: profile) { result in
            switch result {
                
            case .success(_):
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        DatabaseService.shared.getUserProfile { result in
            switch result {
                
            case .success(let user):
                self.profile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: SessionManager.shared.userID) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders.sorted { $0.date > $1.date }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        AuthService.shared.signOut()
    }
}
