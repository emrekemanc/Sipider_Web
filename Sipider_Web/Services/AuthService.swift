//
//  AuthService.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 6.05.2025.
//
import FirebaseAuth

protocol AuthService {
    func registerUser(_ registerModel: RegisterModel, _ completion: @escaping (Result<String, Error>) -> Void)
    func loginUser(_ loginModel: LoginModel, _ completion: @escaping (Result<String, Error>) -> Void)
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthServiceImpl: AuthService {
    private let userService: UserService = UserServiceImpl()
    
    func registerUser(_ registerModel: RegisterModel, _ completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: registerModel.email, password: registerModel.password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred during registration."])))
                return
            }
            completion(.success(user.uid))
        }
    }
    
    func loginUser(_ loginModel: LoginModel, _ completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: loginModel.email, password: loginModel.password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "AuthService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred during login."])))
                return
            }
            completion(.success(user.uid))
        }
    }
    
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
