//
//  FavoriRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class FavoriRouter:FavoriPresenterToRouterProtocol {
    static func createModule(ref: FavoriPage) {
        let presenter = FavoriPresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = FavoriInteractor()
        ref.presenterNesnesi?.view = ref
        ref.presenterNesnesi?.interactor?.presenter = presenter
    }
}
