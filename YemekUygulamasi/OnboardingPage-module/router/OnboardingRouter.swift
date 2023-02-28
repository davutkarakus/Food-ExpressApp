//
//  SplashRouter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import Foundation

class OnboardingRouter : OnboardingPresenterToRouterProtocol {
    static func createModule(ref: OnboardingViewController) {
        let presenter = OnboardingPresenter()
        
        //View
        ref.PresenterNesnesi = presenter
        
        //Presenter
        ref.PresenterNesnesi?.interactor = OnboardingInteractor()
        ref.PresenterNesnesi?.view = ref
        
        //Interactor
        ref.PresenterNesnesi?.interactor?.presenter = presenter
    }
}
