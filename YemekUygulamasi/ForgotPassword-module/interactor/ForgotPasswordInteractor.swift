//
//  ForgotPasswordInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class ForgotPasswordInteractor:ForgotPwPresenterToInteractorProtocol {
    var presenter: ForgotPwInteractorToPresenterProtocol?
    
    func forgotPw(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [self]  (error) in
            if let err = error {
                presenter?.presenteraVeriGonder(err: err)
                presenter?.anyError(bool: true)
            }else {
                presenter?.anyError(bool: false)
            }
        }
    }
}
