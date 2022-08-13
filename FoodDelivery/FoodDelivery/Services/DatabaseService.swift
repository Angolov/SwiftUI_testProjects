//
//  DatabaseService.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation
import FirebaseFirestore

enum DatabaseError: Error {
    case noDataFoundInFirebase
    case wrongDataEntryInFirebase
}

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    private let database = Firestore.firestore()
    private var usersRef: CollectionReference {
        return database.collection("users")
    }
    
    func setProfile(user: AppUser, completion: @escaping (Result<AppUser, Error>) -> Void) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<AppUser, Error>) -> Void) {
        AuthService.shared.getCurrentUserID { [weak self] result in
            switch result {
            case .success(let userID):
                self?.fetchProfileFor(userID: userID, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func fetchProfileFor(userID: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        usersRef.document(userID).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            do {
                let data = try self.getDataFrom(snapshot: snapshot)
                let user = try self.parseUserFrom(data: data)
                completion(.success(user))
            }
            catch (let error) {
                completion(.failure(error))
            }
        }
    }
    
    private func getDataFrom(snapshot: DocumentSnapshot?) throws -> [String : Any] {
        guard let data = snapshot?.data()
        else {
            throw DatabaseError.noDataFoundInFirebase
        }
        
        return data
    }
    
    private func parseUserFrom(data: [String : Any]) throws -> AppUser {
        guard let id = data["id"] as? String,
              let name = data["name"] as? String,
              let phone = data["phone"] as? Int,
              let address = data["address"] as? String
        else {
            throw DatabaseError.wrongDataEntryInFirebase
        }
        
        return AppUser(id: id, name: name, phone: phone, address: address)
    }
}
