//
//  FoodDeliveryApp.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 07.08.2022.
//

import SwiftUI
import FirebaseCore

let screen = UIScreen.main.bounds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FoodDeliveryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AuthViewModel()
            AuthView(viewModel: viewModel)
        }
    }
}
