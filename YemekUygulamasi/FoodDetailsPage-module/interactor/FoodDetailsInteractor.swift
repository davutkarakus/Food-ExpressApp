//
//  FoodDetailsInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import Alamofire
import UIKit

class FoodDetailsInteractor:FoodDetailsPresenterToInteractorProtocol {
    func `sil`(sepet_yemek_id: Int, kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php
        let params = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi] as [String : Any]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("-----DELETE------")
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                    self.sepetiYukle(kullanici_adi: kullanici_adi)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetiYukle(kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php
        let params = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler {
                        self.presenter?.presenteraSepetiGonder(foodList: liste)
                    }
                }catch{
                    self.presenter?.presenteraSepetiGonder(foodList: [SepetYemekler]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var toplam = 1
    
    func toplamMiktar(adet: Int, birimFiyat: Int) {
        toplam = adet * birimFiyat
        presenter?.toplamMiktariPresenteraGonder(toplam: toplam)
    }
    
    var presenter: FoodDetailsInteractorToPresenterProtocol?
    
    var sepetAdet = 1
    func arttir() {
        sepetAdet += 1
        presenter?.presenteraVeriGonder(sayi: sepetAdet)
    }
    
    func azalt() {
        if sepetAdet == 1 {
            
        }else {
            sepetAdet = sepetAdet - 1
            presenter?.presenteraVeriGonder(sayi: sepetAdet)
        }
    }
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php
        let params = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi] as [String : Any]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                    
                }catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

