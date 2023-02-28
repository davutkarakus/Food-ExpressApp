//
//  MainPageInteractor.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation
import Alamofire
import Firebase
import FirebaseAuth
import UIKit

class MainPageInteractor :MainPresenterToInteractorProtocol{
    let user = Auth.auth().currentUser?.email
    var presenter: MainInteractorToPresenterProtocol?
    let db:FMDatabase?
    var tamListe = [Yemekler]()
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("FavoriYemekler.sqlite")
        db = FMDatabase(path: veritabaniURL.path)
    }
    func favoriYukle() {
        var liste = [FavoriYemekler]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM FavoriYemekler WHERE kullanici_ad = ?", values: [user!])
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
            presenter?.presenteraFavoriGonder(favoriList: liste)
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    func favoriKaydet(kullanici_ad: String, yemek_ad: String, yemek_resim: String, yemek_fiyat: Int, yemek_yildiz: String, yemek_zaman: String, yemek_indirim: String) {
            db?.open()
            do {
                try db!.executeUpdate("INSERT INTO FavoriYemekler (kullanici_ad,yemek_ad,yemek_resim,yemek_fiyat,yemek_yildiz,yemek_zaman,yemek_indirim) VALUES (?,?,?,?,?,?,?)", values: [kullanici_ad,yemek_ad,yemek_resim,yemek_fiyat,yemek_yildiz,yemek_zaman,yemek_indirim])
            }catch{
                print(error.localizedDescription)
            }
            db?.close()
    }
    func `sil`(yemek_ad: String) {
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM FavoriYemekler WHERE yemek_ad = ? AND kullanici_ad = ?", values: [yemek_ad,user!])
        }catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    func uploadImage(imageView:UIImageView) {
        let filename = user! + "_profile_picture.jpeg"
        let path = "images/" + filename
        StorageManager.shared.downloadUrl(for: path, completion: { [self]result in
            switch result {
            case .success(let url):
                print(url)
                self.downloadImage(imageView: imageView, url: url)
            case .failure(let err):
                print("Failed to get download url : \(err)")
            }
        })
    }
    func downloadImage(imageView:UIImageView,url:URL){
        URLSession.shared.dataTask(with: url, completionHandler: {data,_,error in
            guard let data = data , error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                print(data)
                imageView.image = image
            }
        }).resume()
    }
    func yemekleriYukle() {
        //GET
        //http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler {
                        self.tamListe = liste
                        self.presenter?.presenteraVeriGonder(yemekListesi: liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func ara(aramaKelimesi: String) {
        var aramaListesi = [Yemekler]()
        for liste in tamListe{
            if liste.yemek_adi!.lowercased().contains(aramaKelimesi.lowercased()) {
                aramaListesi.append(liste)
            }
        }
        self.presenter?.presenteraVeriGonder(yemekListesi: aramaListesi)
    }
    func sepetiYukle(kullanici_adi: String) {
        //http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php
        let params = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response {response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler {
                        self.presenter?.presenteraSepetiGonder(liste: liste)
                    }
                }catch{
                    self.presenter?.presenteraSepetiGonder(liste: [SepetYemekler]())
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
