//
//  SessionManager.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 13.08.2022.
//

import Foundation

// MARK: - SessionManager class

class SessionManager {
    
    // MARK: - Singleton
    
    static let shared = SessionManager()
    private init() {}
    
    // MARK: - Properties
    
    var userID = "" {
        didSet {
            self.getUserProfile()
        }
    }
    var userProfile: AppUser = AppUser(id: "", name: "", phone: "", address: "")
    
    // MARK: - Private methods
    
    private func getUserProfile() {
        DatabaseService.shared.getUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
