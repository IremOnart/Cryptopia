//
//  LoginViewModel.swift
//  Cryptopia
//
//  Created by İrem Onart on 9.08.2023.
//

import FirebaseAuth
import UIKit

class LoginViewModel {
    func signIn(email: String, password: String, completion: ((Error?) -> Void)? = nil) {
        if email == "" || password == "" {
            completion?(AuthError.emailOrPasswordNotValid)
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    completion?(nil)
                } else {
                    completion?(error)
                }
            }
        }
        
    }
    
    func signUp(email: String, password: String, completion: ((Error?) -> Void)? = nil) {
        if email == "" || password == "" {
            completion?(AuthError.emailOrPasswordNotValid)
        }
        else {
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
