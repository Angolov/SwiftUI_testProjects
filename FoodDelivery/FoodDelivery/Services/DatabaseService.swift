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
    case dataWasNotSaved
}

// MARK: - DatabaseService class

class DatabaseService {
    
    // MARK: - Singleton
    
    static let shared = DatabaseService()
    private init() {}
    
    // MARK: - Properties
    
    private let database = Firestore.firestore()
    
    // MARK: - Profile management
    
    private var usersRef: CollectionReference { database.collection("users") }
    
    func setUserProfile(for user: AppUser, completion: @escaping (Result<AppUser, Error>) -> Void) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUserProfile(by id: String = "", completion: @escaping (Result<AppUser, Error>) -> Void) {
        let userID = id == "" ? SessionManager.shared.userID : id
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
    
    // MARK: - Orders management
    
    private var ordersRef: CollectionReference { database.collection("orders") }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> Void) {
        ordersRef.document(order.id).setData(order.representation) { [weak self] error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            self?.setPositions(to: order.id, positions: order.positions) { result in
                switch result {
                case .success(_):
                    completion(.success(order))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
    
    private func getAllOrders(from snapshot: QuerySnapshot) -> [Order] {
        var orders = [Order]()
        for doc in snapshot.documents {
            if let order = Order(doc: doc) {
                orders.append(order)
            }
        }
        return orders
    }
    
    private func filter(orders: [Order], by userID: String) -> [Order] {
        return orders.filter { $0.userID == userID }
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
    
    private func getAllPositions(from snapshot: QuerySnapshot) -> [Position] {
        var positions = [Position]()
        for doc in snapshot.documents {
            if let position = Position(doc: doc) {
                positions.append(position)
            }
        }
        return positions
    }
    
    // MARK: - Products management
    
    private var productsRef: CollectionReference { database.collection("products") }
    
    func setProduct(product: Product, completion: @escaping (Result<Product, Error>) -> Void) {
        
        StorageService.shared.uploadProductImage(id: product.id, image: product.image) { result in
            switch result {
                
            case .success(let sizeInfo):
                print(sizeInfo)
                
                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(DatabaseError.dataWasNotSaved))
                    }
                    completion(.success(product))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        
        self.productsRef.getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let snapshot = snapshot else {
                let error = DatabaseError.noDataFoundInFirebase
                completion(.failure(error))
                return
            }
            
            let docs = snapshot.documents
            var products = [Product]()
            
            for doc in docs {
                if let product = Product(doc: doc) {
                    products.append(product)
                } else {
                    let error = DatabaseError.wrongDataEntryInFirebase
                    completion(.failure(error))
                }
            }
            
            completion(.success(products))
        }
    }
}
