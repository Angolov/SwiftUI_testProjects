//
//  SessionManager.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation

class SessionManager {
    
    static let shared = SessionManager()
    private init() {}
    
    var userID = "" {
        didSet {
            self.getUserProfile()
        }
    }
    var userProfile: AppUser = AppUser(id: "", name: "", phone: 0, address: "")
    
    private func getUserProfile() {
        DatabaseService.shared.getProfile { [weak self] result in
            switch result {
                
            case .success(let profile):
                self?.userProfile = profile
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
