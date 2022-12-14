//
//  AuthService.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 09.08.2022.
//

import Foundation
import FirebaseAuth

// MARK: - AuthServiceError enum

enum AuthServiceError: Error {
    case userNotFound
}

// MARK: - AuthService class

class AuthService {
    
    // MARK: - Singleton
    
    static let shared = AuthService()
    private init() {}
    
    // MARK: - Properties
    
    private let auth = Auth.auth()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    // MARK: - Public methods
    
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email,
                        password: password) { result, error in
            
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in

            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
    }
    
    func getCurrentUserID(completion: @escaping (Result<String, Error>) -> Void) {
        guard let userID = auth.currentUser?.uid else {
            completion(.failure(AuthServiceError.userNotFound))
            return
        }
        completion(.success(userID))
    }
}
