//
//  StorageService.swift
//  FoodDelivery
//
//  Created by Антон Головатый on 20.08.2022.
//

import Foundation
import FirebaseStorage

// MARK: - StorageError enum

enum StorageError: Error {
    case uploadFailed
}

// MARK: - StorageService class

class StorageService {
    
    // MARK: - Singleton
    
    static let shared = StorageService()
    private init() {}
    
    // MARK: - Properties
    
    private let storage = Storage.storage().reference()
    private var productRef: StorageReference {
        storage.child("products")
    }
    
    // MARK: - Public methods
    
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        productRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(StorageError.uploadFailed))
                }
                return
            }
            
            completion(.success("Размер полученного изображения: \(metadata.size)"))
        }
    }
}
