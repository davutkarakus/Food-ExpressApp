//
//  FoodDetailsPresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class FoodDetailsPresenter :FoodDetailsViewToPresenterProtocol{
    func `sil`(sepet_yemek_id: Int, kullanici_adi: String) {
        interactor?.sil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func sepetiYukle(kullanici_adi: String) {
        interactor?.sepetiYukle(kullanici_adi: kullanici_adi)
    }
    
    func toplamMiktar(adet: Int, birimFiyat: Int) {
        interactor?.toplamMiktar(adet: adet, birimFiyat: birimFiyat)
    }
    
    var view: FoodDetailsPresenterToViewProtocol?
    
    func arttir() {
        interactor?.arttir()
    }
    
    func azalt() {
        interactor?.azalt()
    }
    
    var interactor: FoodDetailsPresenterToInteractorProtocol?
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        interactor?.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    
}
extension FoodDetailsPresenter:FoodDetailsInteractorToPresenterProtocol {
    func presenteraSepetiGonder(foodList: [SepetYemekler]) {
        view?.vieweSepetiGonder(foodList: foodList)
    }
    
    func toplamMiktariPresenteraGonder(toplam: Int) {
        view?.toplamMiktariVieweGonder(toplam: toplam)
    }
    
    func presenteraVeriGonder(sayi: Int) {
        view?.vieweVeriGonder(sayi: sayi)
    }
    
    
}
