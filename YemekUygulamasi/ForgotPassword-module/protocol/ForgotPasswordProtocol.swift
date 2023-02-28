//
//  ForgotPasswordProtocl.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

protocol ForgotPwViewToPresenterProtocol {
    var interactor:ForgotPwPresenterToInteractorProtocol? {get set}
    var view:ForgotPwPresenterToViewProtocol? {get set}
    func forgotPw(email:String)
}
protocol ForgotPwPresenterToInteractorProtocol {
    var presenter:ForgotPwInteractorToPresenterProtocol? {get set}
    func forgotPw(email:String)
}
protocol ForgotPwInteractorToPresenterProtocol {
    func presenteraVeriGonder(err:Error)
    func anyError(bool:Bool)
}
protocol ForgotPwPresenterToViewProtocol {
    func vieweVeriGonder(err:Error)
    func anyError(bool:Bool)
}
protocol ForgotPwPresenterToRouterProtocol {
    static func createModule(ref:ForgotPasswordPage)
}

