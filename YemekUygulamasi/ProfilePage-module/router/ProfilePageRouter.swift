//
//  ProfilePageRouter.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 21.02.2023.
//

import Foundation

class ProfilePageRouter:ProfilePresenterToRouterProtocol {
    static func createModule(ref: ProfilePage) {
        let presenter = ProfilePagePresenter()
        ref.presenterNesnesi = presenter
        ref.presenterNesnesi?.interactor = ProfilePageInteractor()
        ref.presenterNesnesi?.interactor?.presenter = presenter
        ref.presenterNesnesi?.view = ref
    }
}
