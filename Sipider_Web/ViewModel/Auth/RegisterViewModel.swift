//
//  RegisterViewModel.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import Foundation


class RegisterViewModel {
    private let authService: AuthService = AuthServiceImpl()
    
    func registerButton(_ userName: String,_ email: String, _ password: String){
        authService.registerUser(RegisterModel(user_name: userName, email: email, password: password)) { result in
            do{
                let user = try result.get()
                print(user)
            }catch{
                
            }
        }
    }
}
