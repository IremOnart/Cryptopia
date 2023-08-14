//
//  SignUpViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 10.08.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let viewModel = SignUpViewModel()
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
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
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let pass = passwordTextField.text,
              let confirmPass = confirmPasswordTextField.text else {
            return
        }
        viewModel.signUp(email: email, password: pass, confirmPassword: confirmPass) { error in
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
    
    @IBAction func haveAnAccountButton(_ sender: Any) {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "SignUpPic")
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at: 0)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.addBottomBorderWithColor(color: UIColor.black, width: 0.5)
        passwordTextField.addBottomBorderWithColor(color: UIColor.black, width: 0.5)
        confirmPasswordTextField.addBottomBorderWithColor(color: UIColor.black, width: 0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}




