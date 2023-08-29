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
    case passwordAndConfirmPasswordNotMatched
    
    var errorDescription: String? {
        switch self {
        case .emailOrPasswordNotValid:
            return "Please enter your email and password !"
        case .passwordAndConfirmPasswordNotMatched:
            return "Password is not confirmed !"
        }
    }
}

class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
//            emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    @IBOutlet weak var showHideLabel: UIButton!
    
    var passwordVisible: Bool = true
    @IBAction func showHideButton(_ sender: Any) {
        if passwordVisible {
                   passwordTextField.isSecureTextEntry = false
                    showHideLabel.setTitle("Hide", for: .normal)
                   passwordVisible = false
               } else {
                   passwordTextField.isSecureTextEntry = true
                   showHideLabel.setTitle("Show", for: .normal)
                   passwordVisible = true
               }
    }
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text else {
            return
        }
        Database.shared.signIn(email: email, password: pass) { error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
//                let vc = CryptoListViewController(nibName: "CryptoListViewController", bundle: nil)
                let vc = TabBarController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        let vc = ForgotPasswordViewController(nibName: "ForgotPasswordViewController" , bundle: nil)
        present(vc, animated: true)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureView()
        SingletonModel.sharedInstance.getUserInfos()
        viewModel.getCoinsDetails()
        
        
    }
    func configureView(){
            passwordTextField.isSecureTextEntry = true
            passwordTextField.clearsOnBeginEditing = false
            showHideLabel.setTitle("Show", for: .normal)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}


