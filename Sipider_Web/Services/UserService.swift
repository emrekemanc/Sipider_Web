//
//  UserService.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 6.05.2025.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserService {
    func createUser(_ userModel: UserModel, _ completion: @escaping (Result<String, Error>) -> Void)
    func fetchUser(_ completion: @escaping (Result<UserModel, Error>) -> Void)
}


class UserServiceImpl: UserService {
    private let db = Firestore.firestore()
    
    private func currentUID() -> Result<String, Error> {
        if let uid = Auth.auth().currentUser?.uid {
            return .success(uid)
        } else {
            return .failure(NSError(domain: "UserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user session found."]))
        }
    }
    
    
    func createUser(_ userModel: UserModel, _ completion: @escaping (Result<String, Error>) -> Void) {
        switch currentUID() {
        case .success(let uid):
            if uid != userModel.id {
                return completion(.failure(NSError(domain: "UserService", code: -3, userInfo: [NSLocalizedDescriptionKey: "UID mismatch."])))
            }
            do {
                let data = try Firestore.Encoder().encode(userModel)
                db.collection("Users").document(uid).setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(uid))
                    }
                }
            } catch {
                completion(.failure(error))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
    func fetchUser(_ completion: @escaping (Result<UserModel, Error>) -> Void) {
        switch currentUID() {
        case .success(let uid):
            db.collection("Users").document(uid).getDocument { document, error in
                if let document = document, document.exists {
                    do {
                        let user = try document.data(as: UserModel.self)
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError(domain: "UserService", code: -2, userInfo: [NSLocalizedDescriptionKey: "User document not found."])))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
