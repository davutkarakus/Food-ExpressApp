//
//  SplashInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class OnboardingInteractor :OnboardingPresenterToInteractorProtocol{
    func control() {
        if Auth.auth().currentUser != nil {
            print("aaa")
            presenter?.presenteraVeriGonder(isSuccess: true)
        }else {
            print("bbbb")
            presenter?.presenteraVeriGonder(isSuccess: false)
        }
    }
    var presenter: OnboardingInteractorToPresenterProtocol?
    
}
