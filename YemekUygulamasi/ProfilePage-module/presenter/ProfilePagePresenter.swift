//
//  ProfilePagePresenter.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 21.02.2023.
//

import Foundation
import UIKit

class ProfilePagePresenter : ProfileViewToPresenterProtocol{
   
    
    var interactor: ProfilePresenterToInteractorProtocol?
    
    var view: ProfilePresenterToViewProtocol?
    func insertUser(tel: String, address: String) {
        interactor?.insertUser(tel: tel, address: address)
    }
    func uploadPhoto(imageView: UIImageView) {
        interactor?.uploadPhoto(imageView: imageView)
    }
    func downloadPhoto(imageView: UIImageView) {
        interactor?.downloadPhoto(imageView: imageView)
    }
    func getTelAndAddress() {
        interactor?.getTelAndAddress()
    }
    
}
extension ProfilePagePresenter : ProfileInteractorToPresenterProtocol {
    func presenteraTelAndAdressGonder(tel: String, address: String) {
        view?.vieweTelAndAdressGonder(tel: tel, address: address)
    }
    
    
}
