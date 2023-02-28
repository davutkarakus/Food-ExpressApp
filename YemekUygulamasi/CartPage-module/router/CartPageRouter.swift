//
//  CartPageRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import Foundation

class CartPageRouter:CartPagePresenterToRouterProtocol {
    static func createModule(ref: CartPagee) {
        let presenter = CartPagePresenter()
        //View
        ref.presenterNesnesi = presenter
        //Presenter
        ref.presenterNesnesi?.interactor = CartPageInteractor()
        ref.presenterNesnesi?.view = ref
        //Interactor
        ref.presenterNesnesi?.interactor?.presenter = presenter
    }
    
    
}
