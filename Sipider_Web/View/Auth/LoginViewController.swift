//
//  LoginController.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var cancellables = Set<AnyCancellable>()
    private let loginViewModel: LoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       observeViewModel()
    }
    private func observeViewModel(){
        loginViewModel.$loginSuccess.receive(on: DispatchQueue.main)
            .sink { [weak self] success in
                if success{
                    print("success")
                    self?.navigateHome()
                    
                }
            }.store(in: &cancellables)
        loginViewModel.$errorMessage.compactMap { $0 }
            .sink { [weak self] error in
                self?.showError(error)
        }.store(in: &cancellables)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTexField.text, let password = passwordTextField.text else{return}
        loginViewModel.loginButton(email, password)
    }
    
    private func navigateHome(){
      performSegue(withIdentifier: "tabBarController", sender: nil)
    }
    
    
    private func showError(_ error: String){
        let alert = UIAlertController(title: "Hata", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
    }
    
}
