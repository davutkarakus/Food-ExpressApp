//
//  FoodDetailsRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class FoodDetailsRouter:FoodDetailsPresenterToRouterProtocol{
    static func createModule(ref: FoodDetailsPage) {
        let presenter = FoodDetailsPresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = FoodDetailsInteractor()
        ref.presenterNesnesi?.interactor?.presenter = presenter
        ref.presenterNesnesi?.view = ref
    }
    
    
}
