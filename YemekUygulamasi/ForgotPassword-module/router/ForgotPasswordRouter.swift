//
//  ForgotPasswordRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class ForgotPasswordRouter:ForgotPwPresenterToRouterProtocol {
    static func createModule(ref: ForgotPasswordPage) {
        let presenter = ForgotPasswordPresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = ForgotPasswordInteractor()
        ref.presenterNesnesi?.view = ref
        ref.presenterNesnesi?.interactor?.presenter = presenter
    }

}
