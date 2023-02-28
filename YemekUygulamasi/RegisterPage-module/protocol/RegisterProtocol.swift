//
//  RegisterProtocol.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

protocol RegisterViewToPresenterProtocol {
    var interactor:RegisterPresenterToInteractorProtocol? {get set}
    var view:RegisterPresenterToViewProtocol? {get set}
    func register(email:String,password:String,username:String)
}
protocol RegisterPresenterToInteractorProtocol {
    var presenter:RegisterInteractorToPresenterProtocol? {get set}
    func register(email:String,password:String,username:String)
}

protocol RegisterInteractorToPresenterProtocol {
    func presenteraVeriGonder(error:Error)
    func anyError(bool:Bool)
}
protocol RegisterPresenterToViewProtocol {
    func vieweVeriGonder(error:Error)
    func anyError(bool:Bool)
}

protocol RegisterPresenterToRouterProtocol {
    static func createModule(ref:RegisterPage)
}
