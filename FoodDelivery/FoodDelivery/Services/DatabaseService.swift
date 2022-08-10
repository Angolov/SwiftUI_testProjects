//
//  DatabaseService.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    private let database = Firestore.firestore()
    private var usersRef: CollectionReference {
        return database.collection("users")
    }
    
    func createUser(user: AppUser, completion: @escaping (Result<AppUser, Error>) -> Void) {
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
