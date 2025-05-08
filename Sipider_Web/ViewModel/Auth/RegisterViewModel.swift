//
//  RegisterViewModel.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import Foundation


class RegisterViewModel {
    private let authService: AuthService = AuthServiceImpl()
    private let userService: UserService = UserServiceImpl()
    @Published var registerSuccess: Bool = false
    @Published var errorMessage: String? = nil
    
    func registerButton(_ userName: String,_ email: String, _ password: String){
        authService.registerUser(RegisterModel(user_name: userName, email: email, password: password)) {[weak self] result in
            DispatchQueue.main.async{
                switch result{
                case .success(let value):
                    let userModel = UserModel(id: value, user_name: userName, email: email, post_count: 0, created_at: Date(), last_activity: Date())
                    self?.userService.createUser(userModel) {[weak self]  result in
                        switch result{
                        case .success(_):
                            self?.registerSuccess = true
                        case .failure(let error):
                            self?.errorMessage = error.localizedDescription
                            self?.registerSuccess = false
                        }
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.registerSuccess = false
                }
            }
        }
    }
}
