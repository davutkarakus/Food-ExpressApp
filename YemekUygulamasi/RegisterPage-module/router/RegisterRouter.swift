//
//  RegisterRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class RegisterRouter :RegisterPresenterToRouterProtocol{
    static func createModule(ref: RegisterPage) {
        let presenter = RegisterPresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.view = ref
        ref.presenterNesnesi?.interactor = RegisterInteractor()
        ref.presenterNesnesi?.interactor?.presenter = presenter
    }
}
