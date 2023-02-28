//
//  RegisterPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class RegisterPresenter :RegisterViewToPresenterProtocol{
    var interactor: RegisterPresenterToInteractorProtocol?
    
    var view: RegisterPresenterToViewProtocol?
    func register(email: String, password: String,username:String) {
        interactor?.register(email: email, password: password,username: username)
    }
}
extension RegisterPresenter:RegisterInteractorToPresenterProtocol {
    func presenteraVeriGonder(error: Error) {
        view?.vieweVeriGonder(error: error)
    }
    
    func anyError(bool: Bool) {
        view?.anyError(bool: bool)
    }
    
}
