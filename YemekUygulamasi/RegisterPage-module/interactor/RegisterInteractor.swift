//
//  RegisterInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class RegisterInteractor :RegisterPresenterToInteractorProtocol{
    var presenter: RegisterInteractorToPresenterProtocol?
    var dp:String = "ali"
    func register(email: String, password: String,username:String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self]authResult,error in
            guard error == nil else {
                presenter?.presenteraVeriGonder(error: error!)
                presenter?.anyError(bool: true)
                return
            }
            let changeRequest = authResult?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { [self]error in
                if let err = error {
                    presenter?.presenteraVeriGonder(error: err)
                }
            }
            do {
            try Auth.auth().signOut()
                
            } catch let signOutError {
            print(signOutError.localizedDescription)
            }
            presenter?.anyError(bool: false)
        }
    }
    
    
}
