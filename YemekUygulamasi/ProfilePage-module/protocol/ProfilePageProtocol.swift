//
//  ProfilePageProtocol.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 21.02.2023.
//

import Foundation
import UIKit

protocol ProfileViewToPresenterProtocol {
    var interactor : ProfilePresenterToInteractorProtocol? {get set}
    var view : ProfilePresenterToViewProtocol? {get set}
    func downloadPhoto(imageView:UIImageView)
    func getTelAndAddress()
    func uploadPhoto(imageView:UIImageView)
    func insertUser(tel:String,address:String)
   
}
protocol ProfilePresenterToInteractorProtocol {
    var presenter:ProfileInteractorToPresenterProtocol? {get set}
    func downloadPhoto(imageView:UIImageView)
    func getTelAndAddress()
    func uploadPhoto(imageView:UIImageView)
    func insertUser(tel:String,address:String)
}
protocol ProfileInteractorToPresenterProtocol {
    func presenteraTelAndAdressGonder(tel:String,address:String)
    
}
protocol ProfilePresenterToViewProtocol {
    func vieweTelAndAdressGonder(tel:String,address:String)
}
protocol ProfilePresenterToRouterProtocol {
    static func createModule(ref:ProfilePage)
}
