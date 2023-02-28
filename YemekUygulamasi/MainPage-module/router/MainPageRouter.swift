//
//  MainPageRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class MainPageRouter:MainPresenterToRouterProtocol {
    static func createModule(ref: MainPage) {
        let presenter = MainPagePresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = MainPageInteractor()
        ref.presenterNesnesi?.view = ref
        ref.presenterNesnesi?.interactor?.presenter = presenter
        
    }
    
    
}
