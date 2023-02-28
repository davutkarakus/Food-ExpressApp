//
//  CartPageInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import Foundation
import Alamofire

class CartPageInteractor :CartPagePresenterToInteractorProtocol{
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php
        let params = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi] as [String : Any]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("-----INSERT------")
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj : \(cevap.message!)")
                    
                }catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    var presenter: CartPageInteractorToPresenterProtocol?
    
    func sepetiYukle(kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php
        let params = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    
                    if let liste = cevap.sepet_yemekler {
                        let sortedList = liste.sorted{$0.yemek_adi! > $1.yemek_adi! }
                        self.presenter?.presenteraVeriGonder(foodList: sortedList)
                    }
                }catch{
                    self.presenter?.presenteraVeriGonder(foodList: [SepetYemekler]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
                }catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    
}
