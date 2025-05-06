//
//  UserService.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 6.05.2025.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth
protocol UserService{
    func createUser(_ userModel: UserModel, _ completion: @escaping(Result<String,Error>) -> Void)
    func fetchUser(_ completion: @escaping(Result<UserModel,Error>)-> Void)
}

class UserServiceImpl: UserService{
    private let db = Firestore.firestore()
    
    
    func createUser(_ userModel: UserModel, _ completion: @escaping(Result<String,Error>) -> Void){
        
        do{
            let data = try Firestore.Encoder().encode(userModel)
            db.collection("Users").document(userModel.id).setData(data){error in
                if error != nil {
                    completion(.failure(error!))
                }else{
                    completion(.success(userModel.id))
                }
            }
        }catch{
            completion(.failure(error))
        }
    }
    
    func fetchUser(_ completion: @escaping(Result<UserModel,Error>)-> Void){
        guard let uid = Auth.auth().currentUser?.uid else{ return completion(.failure(NSError(domain: "User Service", code: -1, userInfo:[NSLocalizedDescriptionKey: "NO OPEN SESSION FOUND!"] )))}
        
            db.collection("Users").document(uid).getDocument{ document, error in
                if let document = document, document.exists{
                    do{
                         let user = try document.data(as: UserModel.self)
                        completion(.success(user))
                      
                    }catch{
                        completion(.failure(error))
                    }
                }else{
                    completion(.failure(error!))
                }
            }
    }
    
    
}
