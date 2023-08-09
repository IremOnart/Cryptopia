//
//  LoginViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 9.08.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

enum AuthError: LocalizedError {
    case emailOrPasswordNotValid
    
    var errorDescription: String? {
        switch self {
        case .emailOrPasswordNotValid:
            return "Please enter your email and password"
        }
    }
}

class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text else {
            return
        }
        viewModel.signIn(email: email, password: pass) { error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let vc = CryptoListViewController(nibName: "CryptoListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text else {
            return
        }
        viewModel.signUp(email: email, password: pass) { error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let vc = CryptoListViewController(nibName: "CryptoListViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}

