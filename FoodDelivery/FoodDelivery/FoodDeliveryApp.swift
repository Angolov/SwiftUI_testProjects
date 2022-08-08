//
//  FoodDeliveryApp.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 07.08.2022.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct FoodDeliveryApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
