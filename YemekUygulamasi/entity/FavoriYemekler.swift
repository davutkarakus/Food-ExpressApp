//
//  FavoriYemekler.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class FavoriYemekler {
    var yemek_id:Int?
    var kullanici_ad:String?
    var yemek_ad:String?
    var yemek_resim:String?
    var yemek_fiyat:Int?
    var yemek_yildiz:String?
    var yemek_zaman:String?
    var yemek_indirim:String?
    init(yemek_id: Int, kullanici_ad: String, yemek_ad: String, yemek_resim: String, yemek_fiyat: Int, yemek_yildiz: String, yemek_zaman: String, yemek_indirim: String) {
        self.yemek_id = yemek_id
        self.kullanici_ad = kullanici_ad
        self.yemek_ad = yemek_ad
        self.yemek_resim = yemek_resim
        self.yemek_fiyat = yemek_fiyat
        self.yemek_yildiz = yemek_yildiz
        self.yemek_zaman = yemek_zaman
        self.yemek_indirim = yemek_indirim
    }
}
