//
//  SignUpViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 10.08.2023.
//

import Foundation
import Firebase
import FirebaseAuth


class SignUpViewModel {
    
    func signUp(email: String, password: String, confirmPassword: String, completion: ((Error?) -> Void)? = nil) {
        if email == "" || password == "" || confirmPassword == "" {
            completion?(AuthError.emailOrPasswordNotValid)
        }
        else if  password != confirmPassword {
            completion?(AuthError.passwordAndConfirmPasswordNotMatched)
        } else if password == confirmPassword {
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil {
                       completion?(nil)
                    } else {
                        completion?(error)
                    }
                }
            
        }
    }
}
