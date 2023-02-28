//
//  FavoriInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class FavoriInteractor :FavoriPresenterToInteractorProtocol{
    var presenter: FavoriInteractorToPresenterProtocol?
    let db:FMDatabase?
    let kullanici_ad = Auth.auth().currentUser?.email
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("FavoriYemekler.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    func favoriYukle() {
        var liste = [FavoriYemekler]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM FavoriYemekler WHERE kullanici_ad = ?", values: [kullanici_ad!])
            while rs.next() {
                let yemek_id = Int(rs.string(forColumn: "yemek_id"))!
                let yemek_ad = rs.string(forColumn: "yemek_ad")!
                let yemek_resim = rs.string(forColumn: "yemek_resim")!
                let yemek_fiyat = Int(rs.string(forColumn: "yemek_fiyat"))!
                let yemek_indirim = rs.string(forColumn: "yemek_indirim")!
                let yemek_yildiz = rs.string(forColumn: "yemek_yildiz")!
                let yemek_zaman = rs.string(forColumn: "yemek_zaman")!
                let kullanici_ad = rs.string(forColumn: "kullanici_ad")!
                let favoriYemekler = FavoriYemekler(yemek_id: yemek_id, kullanici_ad: kullanici_ad, yemek_ad: yemek_ad, yemek_resim: yemek_resim, yemek_fiyat: yemek_fiyat, yemek_yildiz: yemek_yildiz, yemek_zaman: yemek_zaman, yemek_indirim: yemek_indirim)
                liste.append(favoriYemekler)
            }
            presenter?.presenteraVeriGonder(favoriList: liste)
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func `sil`(yemek_id: Int) {
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM FavoriYemekler WHERE yemek_id = ?", values: [yemek_id])
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
}
