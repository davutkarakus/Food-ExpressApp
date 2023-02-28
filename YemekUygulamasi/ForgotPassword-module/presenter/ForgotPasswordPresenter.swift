//
//  ForgotPasswordPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class ForgotPasswordPresenter :ForgotPwViewToPresenterProtocol{
    var interactor: ForgotPwPresenterToInteractorProtocol?
    
    var view: ForgotPwPresenterToViewProtocol?
    
    func forgotPw(email: String) {
        interactor?.forgotPw(email: email)
    }
    
}
extension ForgotPasswordPresenter:ForgotPwInteractorToPresenterProtocol {
    func anyError(bool: Bool) {
        view?.anyError(bool: bool)
    }
    
    func presenteraVeriGonder(err: Error) {
        view?.vieweVeriGonder(err: err)
    }

}
