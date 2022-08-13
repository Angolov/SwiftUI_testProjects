//
//  ProfileViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var profile: AppUser!
    
    init(profile: AppUser) {
        self.profile = profile
    }
    
    init() {
        getProfile()
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
}
