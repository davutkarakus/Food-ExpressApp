//
//  FavoriPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class FavoriPresenter :FavoriViewToPresenterProtocol{
    var interactor: FavoriPresenterToInteractorProtocol?
    
    var view: FavoriPresenterToViewProtocol?
    
    func favoriYukle() {
        interactor?.favoriYukle()
    }
    
    func `sil`(yemek_id: Int) {
        interactor?.sil(yemek_id: yemek_id)
    }
    
    
}
extension FavoriPresenter:FavoriInteractorToPresenterProtocol {
    func presenteraVeriGonder(favoriList: [FavoriYemekler]) {
        view?.vieweVeriGonder(favoriList: favoriList)
    }
    
    
}
