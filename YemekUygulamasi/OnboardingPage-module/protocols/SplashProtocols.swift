//
//  SplashProtocols.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import Foundation

protocol OnboardingViewToPresenterProtocol {
    var interactor:OnboardingPresenterToInteractorProtocol? {get set}
    var view:OnboardingPresenterToViewProtocol? {get set}
    func control()
}
protocol OnboardingPresenterToInteractorProtocol {
    var presenter:OnboardingInteractorToPresenterProtocol? {get set}
    func control()
}

protocol OnboardingInteractorToPresenterProtocol {
    func presenteraVeriGonder(isSuccess:Bool)
}
protocol OnboardingPresenterToViewProtocol {
    func vieweVeriGonder(isSuccess:Bool)
}
protocol OnboardingPresenterToRouterProtocol {
    static func createModule(ref:OnboardingViewController)
}
