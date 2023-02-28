//
//  CartPageProtocol.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import Foundation

protocol CartPageViewToPresenterProtocol {
    var interactor:CartPagePresenterToInteractorProtocol? {get set}
    var view:CartPagePresenterToViewProtocol? {get set}
    func sepetiYukle(kullanici_adi:String)
    func sil(sepet_yemek_id:Int,kullanici_adi:String)
    func sepeteEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}
protocol CartPagePresenterToInteractorProtocol {
    var presenter:CartPageInteractorToPresenterProtocol? {get set}
    func sepetiYukle(kullanici_adi:String)
    func sil(sepet_yemek_id:Int,kullanici_adi:String)
    func sepeteEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
}
protocol CartPageInteractorToPresenterProtocol {
    func presenteraVeriGonder(foodList:[SepetYemekler])
}
protocol CartPagePresenterToViewProtocol {
    func vieweVeriGonder(foodList:[SepetYemekler])
}
protocol CartPagePresenterToRouterProtocol {
    static func createModule(ref:CartPagee)
}
