//
//  DatabaseService.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 10.08.2022.
//

import Foundation
import FirebaseFirestore

// MARK: - DatabaseError enum

enum DatabaseError: Error {
    case noDataFoundInFirebase
    case wrongDataEntryInFirebase
}

// MARK: - DatabaseService class

class DatabaseService {
    
    // MARK: - Singleton
    
    static let shared = DatabaseService()
    private init() {}
    
    // MARK: - Properties
    
    private let database = Firestore.firestore()
    private var usersRef: CollectionReference {
        return database.collection("users")
    }
    
    private var ordersRef: CollectionReference {
        return database.collection("orders")
    }
    
    // MARK: - Public methods
    
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
        usersRef.document(SessionManager.shared.userID).getDocument { [weak self] snapshot, error in
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
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> Void) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self.setPositions(to: order.id, positions: order.positions) { result in
                switch result {
                case .success(_):
                    completion(.success(order))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> Void) {
        
        ordersRef.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                let error = DatabaseError.noDataFoundInFirebase
                completion(.failure(error))
                return
            }
            
            var orders = self.getAllOrders(from: snapshot)
            
            if let userID = userID {
                orders = self.filter(orders: orders, by: userID)
            }
            
            completion(.success(orders))
        }
    }
    
    func getPositions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> Void) {
        let positionsRef = ordersRef.document(orderID).collection("positions")
        positionsRef.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                let error = DatabaseError.noDataFoundInFirebase
                completion(.failure(error))
                return
            }
            
            let positions = self.getAllPositions(from: snapshot)
            completion(.success(positions))
        }
    }
    
    // MARK: - Private methods
    
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
    
    private func setPositions(to orderID: String,
                      positions: [Position],
                      completion: @escaping (Result<[Position], Error>) -> Void) {
        
        let positionsRef = ordersRef.document(orderID).collection("positions")
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        completion(.success(positions))
    }
    
    private func getAllPositions(from snapshot: QuerySnapshot) -> [Position] {
        var positions = [Position]()
        for doc in snapshot.documents {
            if let position = Position(doc: doc) {
                positions.append(position)
            }
        }
        return positions
    }
    
    private func getAllOrders(from snapshot: QuerySnapshot) -> [Order] {
        var orders = [Order]()
        for doc in snapshot.documents {
            if let order = Order(doc: doc){
                orders.append(order)
            }
        }
        return orders
    }
    
    private func filter(orders: [Order], by userID: String) -> [Order] {
        return orders.filter { $0.userID == userID }
    }
}
