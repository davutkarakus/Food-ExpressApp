//
//  MainPageProtocol.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation
import UIKit

protocol MainViewToPresenterProtocol {
    var interactor:MainPresenterToInteractorProtocol? {get set}
    var view:MainPresenterToViewProtocol? {get set}
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
    func favoriKaydet(kullanici_ad:String,yemek_ad:String,yemek_resim:String,yemek_fiyat:Int,yemek_yildiz:String,yemek_zaman:String,yemek_indirim:String)
    func sepetiYukle(kullanici_adi:String)
    func uploadImage(imageView:UIImageView)
    func favoriYukle()
    func sil(yemek_ad:String)
    
}
protocol MainPresenterToInteractorProtocol {
    var presenter:MainInteractorToPresenterProtocol? {get set}
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
    func favoriKaydet(kullanici_ad:String,yemek_ad:String,yemek_resim:String,yemek_fiyat:Int,yemek_yildiz:String,yemek_zaman:String,yemek_indirim:String)
    func sepetiYukle(kullanici_adi:String)
    func uploadImage(imageView:UIImageView)
    func favoriYukle()
    func sil(yemek_ad:String)
}
protocol MainInteractorToPresenterProtocol {
    func presenteraSepetiGonder(liste:[SepetYemekler])
    func presenteraVeriGonder(yemekListesi:[Yemekler])
    func presenteraFavoriGonder(favoriList:[FavoriYemekler])
}
protocol MainPresenterToViewProtocol {
    func vieweSepetiGonder(liste:[SepetYemekler])
    func vieweVeriGonder(yemekListesi:[Yemekler])
    func vieweFavoriGonder(favoriList:[FavoriYemekler])
}
protocol MainPresenterToRouterProtocol {
    static func createModule(ref:MainPage)
}
