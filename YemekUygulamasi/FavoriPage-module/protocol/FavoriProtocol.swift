//
//  FavoriProtocl.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

protocol FavoriViewToPresenterProtocol {
    var interactor:FavoriPresenterToInteractorProtocol? {get set}
    var view:FavoriPresenterToViewProtocol? {get set}
    func favoriYukle()
    func sil(yemek_id:Int)
    
}
protocol FavoriPresenterToInteractorProtocol {
    var presenter:FavoriInteractorToPresenterProtocol? {get set}
    func favoriYukle()
    func sil(yemek_id:Int)
}
protocol FavoriInteractorToPresenterProtocol {
    func presenteraVeriGonder(favoriList:[FavoriYemekler])
}
protocol FavoriPresenterToViewProtocol {
    func vieweVeriGonder(favoriList:[FavoriYemekler])
}
protocol FavoriPresenterToRouterProtocol {
    static func createModule(ref:FavoriPage)
}
