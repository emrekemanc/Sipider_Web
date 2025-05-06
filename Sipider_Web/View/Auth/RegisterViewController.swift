//
//  RegisterController.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private let registerViewModel: RegisterViewModel = RegisterViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerButton(_ sender: UIButton) {
        registerViewModel.registerButton(userNameTextField.text!, emailTextField.text!, passwordTextField.text!)
        dismiss(animated: true)
    }
    
}
