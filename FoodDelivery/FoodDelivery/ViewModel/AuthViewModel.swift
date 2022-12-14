//
//  AuthViewModel.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation
import FirebaseAuth

// MARK: - AuthError enum

enum AuthError: Error {
    
    case passwordsNotSame
}

// MARK: - AuthViewModel class

class AuthViewModel: ObservableObject {
    
    // MARK: - Properties
    
    var messageTitle = ""
    var messageText = ""
    
    // MARK: - Public methods
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        AuthService.shared.signIn(email: email, password: password) { [weak self] result in
            switch result {
                
            case .success(let user):
                SessionManager.shared.userID = user.uid
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
        
        AuthService.shared.signUp(email: email, password: password) { [weak self] result in
            switch result {
                
            case .success(let user):
                self?.messageTitle = "Поздравляем!"
                self?.messageText = "Вы успешно зарегистрированы. Ваш логин - \(user.email ?? "")"
                self?.addUserToDatabase(user: user, completion: completion)
                
            case .failure(let error):
                self?.messageTitle = "Ошибка регистрации"
                self?.messageText = error.localizedDescription
                completion(.failure(error))
            }
        }
    }
    
    func checkSavedAuthData(completion: @escaping (Bool) -> Void) {
        AuthService.shared.getCurrentUserID { result in
            switch result {
                
            case .success(let userID):
                SessionManager.shared.userID = userID
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func isAdmin() -> Bool {
        return AuthService.shared.currentUser?.uid == "qCSmEYEtabXrOX7baTEautegkS12"
    }
    
    // MARK: - Private methods
    
    private func addUserToDatabase(user: User, completion: @escaping (Result<User, Error>) -> Void) {
        let appUser = AppUser(id: user.uid,
                              name: user.email ?? "",
                              phone: "",
                              address: "")
        
        DatabaseService.shared.setUserProfile(for: appUser) { result in
            switch result {
                
            case .success(_):
                SessionManager.shared.userID = user.uid
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
