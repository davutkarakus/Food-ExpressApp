//
//  LoginPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class LoginPresenter :LoginViewToPresenterProtocol{
    var interactor: LoginPresenterToInteractorProtocol?
    
    var view: LoginPresenterToViewProtocol?
    
    func login(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    
}
extension LoginPresenter:LoginInteractorToPresenterProtocol {
    func isLogin(user: Bool) {
        view?.isLogin(user: user)
    }
    
    func presenteraVeriGonder(err: Error) {
        view?.vieweVeriGonder(err: err)
    }
    
    
}
