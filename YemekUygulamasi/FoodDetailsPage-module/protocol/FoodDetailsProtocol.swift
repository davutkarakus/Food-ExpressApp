//
//  FoodDetailsProtocol.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

protocol FoodDetailsViewToPresenterProtocol {
    var interactor:FoodDetailsPresenterToInteractorProtocol? {get set}
    var view : FoodDetailsPresenterToViewProtocol? {get set}
    func sepeteEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
        func arttir()
        func azalt()
        func toplamMiktar(adet:Int,birimFiyat:Int)
    func sepetiYukle(kullanici_adi:String)
    func sil(sepet_yemek_id:Int,kullanici_adi:String)
    
}
protocol FoodDetailsPresenterToInteractorProtocol {
    var presenter:FoodDetailsInteractorToPresenterProtocol? {get set}
    
    func sepeteEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:Int,yemek_siparis_adet:Int,kullanici_adi:String)
        func arttir()
        func azalt()
        func toplamMiktar(adet:Int,birimFiyat:Int)
        func sepetiYukle(kullanici_adi:String)
        func sil(sepet_yemek_id:Int,kullanici_adi:String)
}
protocol FoodDetailsInteractorToPresenterProtocol {
    func presenteraSepetiGonder(foodList:[SepetYemekler])
    func presenteraVeriGonder(sayi:Int)
    func toplamMiktariPresenteraGonder(toplam:Int)
    
}
protocol FoodDetailsPresenterToViewProtocol {
    func vieweSepetiGonder(foodList:[SepetYemekler])
    func vieweVeriGonder(sayi:Int)
    func toplamMiktariVieweGonder(toplam:Int)
}

protocol FoodDetailsPresenterToRouterProtocol {
    static func createModule(ref:FoodDetailsPage)
}
