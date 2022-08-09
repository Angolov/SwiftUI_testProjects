//
//  AuthView.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 07.08.2022.
//

import SwiftUI

// MARK: - AuthView struct

struct AuthView: View {
    
    // MARK: - Properties
    
    @State private var userLogin = ""
    @State private var userPassword = ""
    @State private var confirmPassword = ""
    @State private var showRegistrationForm = false
    @State private var showTabView = false
    @State private var showAuthAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 30) {
            titleText
                
            VStack {
                EmailField(text: $userLogin)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                PasswordField(placeholder: "Введите пароль", text: $userPassword)
                    .padding(8)
                    .padding(.horizontal, 12)
                
                if showRegistrationForm {
                    PasswordField(placeholder: "Повторите пароль", text: $confirmPassword)
                        .padding(8)
                        .padding(.horizontal, 12)
                }
                
                proceedButton
                    .padding()
                    .padding(.horizontal, 12)
                
                formSwitchButton
                    .padding(8)
                    .padding(.horizontal, 12)
            }
            .padding()
            .padding(.top, 16)
            .background(Color("WhiteAlpha"))
            .cornerRadius(24)
            .padding(showRegistrationForm ? 12 : 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundImage)
        .animation(Animation.easeInOut(duration: 0.3), value: showRegistrationForm)
        .fullScreenCover(isPresented: $showTabView) {
            MainTabBar()
        }
        .alert(alertTitle, isPresented: $showAuthAlert) {
            Button("ОК", action: {})
        } message: {
            Text(alertMessage)
        }
    }
}

// MARK: - UI elements

extension AuthView {
    
    private var titleText: some View {
        Text(showRegistrationForm ? "Регистрация" : "Авторизация")
            .padding(showRegistrationForm ? 24 : 16)
            .padding(.horizontal, 30)
            .font(.title2.bold())
            .background(Color("WhiteAlpha"))
            .cornerRadius(showRegistrationForm ? 60 : 30)
    }
    
    private var proceedButton: some View {
        Button(action: proceedButtonTapped) {
            Text(showRegistrationForm ? "Создать аккаунт" : "Войти")
                .padding()
                .frame(maxWidth: .infinity)
                .background(buttonColorGradient)
                .cornerRadius(12)
                .font(.title3.bold())
                .foregroundColor(Color("DarkBrown"))
        }
    }
    
    private var buttonColorGradient: some View {
        LinearGradient(colors: [Color("Yellow"), Color("Orange")],
                       startPoint: .leading,
                       endPoint: .trailing)
    }
    
    private var formSwitchButton: some View {
        Button(action: formSwitchButtonTapped) {
            Text(showRegistrationForm ? "Уже есть аккаунт" : "Еще не с нами?")
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .font(.title3.bold())
                .foregroundColor(Color("DarkBrown"))
        }
    }
    
    private var backgroundImage: some View {
        Image("Background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
            .blur(radius: showRegistrationForm ? 2 : 0)
    }
}

// MARK: - Actions

extension AuthView {
    
    private func proceedButtonTapped() {
        if showRegistrationForm {
            print("Register is tapped")
            registerUser()
        } else {
            print("Login is tapped")
            loginWithUser()
        }
    }
    
    private func formSwitchButtonTapped() {
        showRegistrationForm.toggle()
    }
}

// MARK: - Private methods

extension AuthView {
    
    private func registerUser() {
        guard userPassword == confirmPassword else {
            alertTitle = "Ошибка"
            alertMessage = "Пароль не совпадает"
            showAuthAlert = true
            return
        }
        
        AuthService.shared.signUp(email: self.userLogin,
                                  password: self.userPassword) { result in
            
            switch result {
                
            case .success(let user):
                alertTitle = "Поздравляем!"
                alertMessage = "Вы успешно зарегистрированы. Ваш логин - \(user.email ?? "")"
                showAuthAlert = true
                cleanTextFields()
                showRegistrationForm = false
                
            case .failure(let error):
                alertTitle = "Ошибка регистрации"
                alertMessage = error.localizedDescription
                showAuthAlert = true
            }
        }
    }
    
    private func cleanTextFields() {
        userLogin = ""
        userPassword = ""
        confirmPassword = ""
    }
    
    private func loginWithUser() {
        AuthService.shared.signIn(email: self.userLogin,
                                  password: self.userPassword) { result in
            switch result {
                
            case .success(_):
                cleanTextFields()
                showTabView = true
                
            case .failure(let error):
                alertTitle = "Ошибка регистрации"
                alertMessage = error.localizedDescription
                showAuthAlert = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
