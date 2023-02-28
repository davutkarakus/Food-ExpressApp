//
//  LoginInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginInteractor :LoginPresenterToInteractorProtocol{
    var presenter: LoginInteractorToPresenterProtocol?
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password){[weak self]authResult,error in
            guard self != nil else {return}
            if let err = error {
                self?.presenter?.isLogin(user: false)
                self?.presenter?.presenteraVeriGonder(err: err)
            }else if Auth.auth().currentUser != nil {
                self?.presenter?.isLogin(user: true)
            }
        }
    }
    
    
}
