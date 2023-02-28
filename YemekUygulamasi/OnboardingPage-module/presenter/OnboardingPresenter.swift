//
//  SplashPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import Foundation

class OnboardingPresenter:OnboardingViewToPresenterProtocol {
    var view: OnboardingPresenterToViewProtocol?
    var interactor: OnboardingPresenterToInteractorProtocol?
    
    func control() {
        interactor?.control()
    }
}
extension OnboardingPresenter:OnboardingInteractorToPresenterProtocol {
    func presenteraVeriGonder(isSuccess: Bool) {
        view?.vieweVeriGonder(isSuccess: isSuccess)
    }
}
