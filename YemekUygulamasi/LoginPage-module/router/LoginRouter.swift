//
//  LoginRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class LoginRouter:LoginPresenterToRouterProtocol {
    static func createModule(ref: LoginPage) {
        let presenter = LoginPresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = LoginInteractor()
        ref.presenterNesnesi?.view = ref
        ref.presenterNesnesi?.interactor?.presenter = presenter
    }
    
}
