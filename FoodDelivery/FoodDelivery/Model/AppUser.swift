//
//  AppUser.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation

// MARK: - AppUser struct

struct AppUser: Identifiable {
    
    // MARK: - Properties
    
    var id: String
    var name: String
    var phone: String
    var address: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phone
        repres["address"] = self.address
        return repres
    }
}
