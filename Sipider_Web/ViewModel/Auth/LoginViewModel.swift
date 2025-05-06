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
    
    func loginButton(_ email: String, _ password: String){
        
        authService.loginUser(LoginModel(email: email, password: password)) { result in
            do{
                let uid = try result.get()
                print(uid)
                self.userService.fetchUser { result in
                    do{
                        let r = try result.get()
                        print(r)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    


}
