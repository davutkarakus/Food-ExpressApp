//
//  LoginProtocol.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

protocol LoginViewToPresenterProtocol {
    var interactor:LoginPresenterToInteractorProtocol? {get set}
    var view:LoginPresenterToViewProtocol? {get set}
    func login(email:String,password:String)
}
protocol LoginPresenterToInteractorProtocol {
    var presenter:LoginInteractorToPresenterProtocol? {get set}
    func login(email:String,password:String)
}

protocol LoginInteractorToPresenterProtocol {
    func isLogin(user:Bool)
    func presenteraVeriGonder(err:Error)
}
protocol LoginPresenterToViewProtocol {
    func isLogin(user:Bool)
    func vieweVeriGonder(err:Error)
}

protocol LoginPresenterToRouterProtocol {
    static func createModule(ref:LoginPage)
}
