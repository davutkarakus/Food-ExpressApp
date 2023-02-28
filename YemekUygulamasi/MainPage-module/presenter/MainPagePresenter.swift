//
//  MainPagePresenter.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation
import UIKit
class MainPagePresenter :MainViewToPresenterProtocol{
    func favoriYukle() {
        interactor?.favoriYukle()
    }

    var interactor: MainPresenterToInteractorProtocol?
    
    var view: MainPresenterToViewProtocol?
    
    func favoriKaydet(kullanici_ad: String, yemek_ad: String, yemek_resim: String, yemek_fiyat: Int, yemek_yildiz: String, yemek_zaman: String, yemek_indirim: String) {
        interactor?.favoriKaydet(kullanici_ad: kullanici_ad, yemek_ad: yemek_ad, yemek_resim: yemek_resim, yemek_fiyat: yemek_fiyat, yemek_yildiz: yemek_yildiz, yemek_zaman: yemek_zaman, yemek_indirim: yemek_indirim)
    }
    func sepetiYukle(kullanici_adi: String) {
        interactor?.sepetiYukle(kullanici_adi: kullanici_adi)
    }

    func yemekleriYukle() {
        interactor?.yemekleriYukle()
    }
    func uploadImage(imageView: UIImageView) {
        interactor?.uploadImage(imageView: imageView)
    }
    
    func `sil`(yemek_ad:String) {
        interactor?.sil(yemek_ad: yemek_ad)
    }
    func ara(aramaKelimesi: String) {
        interactor?.ara(aramaKelimesi: aramaKelimesi)
    }

}
extension MainPagePresenter:MainInteractorToPresenterProtocol {
    func presenteraFavoriGonder(favoriList: [FavoriYemekler]) {
        view?.vieweFavoriGonder(favoriList: favoriList)
    }
    
    func presenteraSepetiGonder(liste: [SepetYemekler]) {
        view?.vieweSepetiGonder(liste: liste)
    }
    
    func presenteraVeriGonder(yemekListesi: [Yemekler]) {
        view?.vieweVeriGonder(yemekListesi: yemekListesi)
    }
    
    
}
