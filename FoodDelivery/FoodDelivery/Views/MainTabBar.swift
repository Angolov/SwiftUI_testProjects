//
//  MainTabBar.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 08.08.2022.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        TabView {
            CatalogueView()
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Каталог")
                    }
                }
            
            CartView()
                .tabItem {
                VStack {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
            }
            
            ProfileView()
                .tabItem {
                VStack {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }
            }
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
    }
}
