//
//  SignUpViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 10.08.2023.
//

import UIKit
import TextFieldEffects

class SignUpViewController: UIViewController {
    
    let viewModel = SignUpViewModel()
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var usernameTextFied: HoshiTextField!
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: confirmPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    @IBOutlet weak var passwordShowHideLabel: UIButton!
    @IBOutlet weak var passwordConfirmShowHideLabel: UIButton!
    var passwordVisible1: Bool = true
    var passwordVisible2: Bool = true
    @IBAction func passwordShowHide(_ sender: Any) {
        if passwordVisible1 {
            passwordTextField.isSecureTextEntry = false
            passwordShowHideLabel.setTitle("Hide", for: .normal)
            passwordVisible1 = false
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordShowHideLabel.setTitle("Show", for: .normal)
            passwordVisible1 = true
        }
    }
    
    @IBAction func passwordConfirmShowHide(_ sender: Any) {
        if passwordVisible2 {
            confirmPasswordTextField.isSecureTextEntry = false
            passwordConfirmShowHideLabel.setTitle("Hide", for: .normal)
            passwordVisible2 = false
        } else {
            confirmPasswordTextField.isSecureTextEntry = true
            passwordConfirmShowHideLabel.setTitle("Show", for: .normal)
            passwordVisible2 = true
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text,
              let username = usernameTextFied.text,
              let confirmPass = confirmPasswordTextField.text else {
            return
        }
        Database.shared.signUp(name: username, email: email, password: pass, confirmPassword: confirmPass) { error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let vc = TabBarController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func haveAnAccountButton(_ sender: Any) {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        configureView()
    }
    
    func configureView(){
            passwordTextField.isSecureTextEntry = true
            passwordTextField.clearsOnBeginEditing = false
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.clearsOnBeginEditing = false
            passwordShowHideLabel.setTitle("Show", for: .normal)
            passwordConfirmShowHideLabel.setTitle("show", for: .normal)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}




