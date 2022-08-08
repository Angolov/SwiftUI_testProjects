//
//  ContentView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 07.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userLogin = ""
    @State private var userPassword = ""
    
    var body: some View {
        
        VStack(spacing: 30){
            Text("Авторизация")
                .padding()
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color("WhiteAlpha"))
                .cornerRadius(30)
                
            VStack {
                TextField("Введите email", text: $userLogin)
                    .padding()
                    .background(Color("WhiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Введите пароль", text: $userPassword)
                    .padding()
                    .background(Color("WhiteAlpha"))
                    .cornerRadius(12)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                Button(action: loginButtonTapped) {
                    Text("Войти")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColorGradient)
                        .cornerRadius(12)
                        .padding()
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("DarkBrown"))
                }
                
                Button(action: wishToRegisterButtonTapped) {
                    Text("Еще не с нами?")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundColor(Color("DarkBrown"))
                }
                
            }
            .padding()
            .padding(.top, 16)
            .background(Color("WhiteAlpha"))
            .cornerRadius(24)
            .padding(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundImage)
    }
    
    private var backgroundImage: some View {
        Image("Background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
    
    private var buttonColorGradient: some View {
        LinearGradient(colors: [Color("Yellow"), Color("Orange")],
                       startPoint: .leading,
                       endPoint: .trailing)
    }
    
    private func loginButtonTapped() {
        print("Login tapped")
    }
    
    private func wishToRegisterButtonTapped() {
        print("Wish to register tapped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
