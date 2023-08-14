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
            emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
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
//                let vc = CryptoListViewController(nibName: "CryptoListViewController", bundle: nil)
                let vc = TabBarController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LoginPic")
        backgroundImage.contentMode = .scaleToFill
        view.insertSubview(backgroundImage, at: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailTextField.addBottomBorderWithColor(color: UIColor.black, width: 0.5)
        passwordTextField.addBottomBorderWithColor(color: UIColor.black, width: 0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}
extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}


