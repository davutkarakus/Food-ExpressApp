//
//  CartPagePresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import Foundation

class CartPagePresenter:CartPageViewToPresenterProtocol {
   
    
    var interactor: CartPagePresenterToInteractorProtocol?
    
    var view: CartPagePresenterToViewProtocol?
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        interactor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    func sepetiYukle(kullanici_adi: String) {
        interactor?.sepetiYukle(kullanici_adi: kullanici_adi)
    }
    
    func `sil`(sepet_yemek_id: Int, kullanici_adi: String) {
        interactor?.sil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    
}
extension CartPagePresenter:CartPageInteractorToPresenterProtocol {
    func presenteraVeriGonder(foodList: [SepetYemekler]) {
        view?.vieweVeriGonder(foodList: foodList)
    }
    
    
}
