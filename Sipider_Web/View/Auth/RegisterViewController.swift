//
//  RegisterController.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private let viewModel: RegisterViewModel
    private var cancellables = Set<AnyCancellable>()
    
    var onRegisterSuccess: (() -> Void)?
    
    // Bağımlılık enjeksiyonu için özel init
    init?(coder: NSCoder, viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("Storyboard üzerinden bu sınıf başlatılmamalı. ViewModel verilmelidir.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }

    private func observeViewModel() {
        viewModel.$registerSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] success in
                if success {
                    self?.onRegisterSuccess?()
                }
            }.store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showError(error)
            }.store(in: &cancellables)
    }

    @IBAction func registerButton(_ sender: UIButton) {
        viewModel.validateAndRegister(
            userName: userNameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text
        )
    }

    private func showError(_ error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hata", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
        }
    }
}
