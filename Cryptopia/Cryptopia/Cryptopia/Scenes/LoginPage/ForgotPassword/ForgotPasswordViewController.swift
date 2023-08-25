//
//  ForgetPasswordViewController.swift
//  Cryptopia
//
//  Created by İrem Onart on 24.08.2023.
//

import UIKit
import TextFieldEffects

class ForgotPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var emailTextField: HoshiTextField!
    
    
    @IBAction func sendButton(_ sender: Any) {
        Database.shared.resetPassword(email: emailTextField.text ?? "") { error in
            if error != nil {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                return
            }
            print("success")
            let alertController = UIAlertController(title: "", message: "We have just send you a password reset email. Please cehck your inbox and follow the instructions to reset your password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.dismiss(animated: true)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

