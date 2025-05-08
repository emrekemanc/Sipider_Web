//
//  LoginViewModel.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import Foundation


class LoginViewModel {
    private let authService: AuthService = AuthServiceImpl()
    private let userService: UserService = UserServiceImpl()
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String? = nil
    
    func loginButton(_ email: String, _ password: String){
        authService.loginUser(LoginModel(email: email, password: password)) {[weak self] result in
            DispatchQueue.main.async {
                print(result)
                switch result{
                case .success(_):
                    self?.loginSuccess = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.loginSuccess = false
                }
            }
                
            
        }
    }
    


}
