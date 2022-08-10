//
//  AuthViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    
    case passwordsNotSame
}

class AuthViewModel: ObservableObject {
    
    var messageTitle = ""
    var messageText = ""
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        AuthService.shared.signIn(email: email,
                                  password: password) { [weak self] result in
            switch result {
                
            case .success(let user):
                completion(.success(user))
                
            case .failure(let error):
                self?.messageTitle = "Ошибка регистрации"
                self?.messageText = error.localizedDescription
                completion(.failure(error))
            }
        }
    }
    
    func signUp(email: String,
                password: String,
                confirmPassword: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        guard password == confirmPassword else {
            let error = AuthError.passwordsNotSame
            messageTitle = "Ошибка"
            messageText = "Пароль не совпадает"
            completion(.failure(error))
            return
        }
        
        AuthService.shared.signUp(email: email,
                                  password: password) { [weak self] result in
            switch result {
                
            case .success(let user):
                self?.messageTitle = "Поздравляем!"
                self?.messageText = "Вы успешно зарегистрированы. Ваш логин - \(user.email ?? "")"
                completion(.success(user))
                
            case .failure(let error):
                self?.messageTitle = "Ошибка регистрации"
                self?.messageText = error.localizedDescription
                completion(.failure(error))
            }
        }
    }
}
