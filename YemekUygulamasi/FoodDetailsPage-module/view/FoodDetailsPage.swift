//
//  FoodDetailsPage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth
protocol DetailsToMainProtocol {
    func badgeSayiGonder(sayi:Int)
}
class FoodDetailsPage: UIViewController {
    
    @IBOutlet weak var labelDakika: UILabel!
    @IBOutlet weak var labelSepetAdet: UILabel!
    @IBOutlet weak var labelBirimFiyat: UILabel!
    @IBOutlet weak var labelFoodName: UILabel!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var buttonSepeteEkle: UIButton!
    @IBOutlet weak var bottomCardView: UIView!
    var dtm:DetailsToMainProtocol?
    var yemekZaman:String?
    var yemek:Yemekler?
    var kullaniciAdi = Auth.auth().currentUser?.email
    var cnb = CustomNavBar()
    var sayi:Int?
    var presenterNesnesi:FoodDetailsViewToPresenterProtocol?
    var badgeSayi = 0
    var sepetYemekler = [SepetYemekler]()
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allDesign()
        FoodDetailsRouter.createModule(ref: self)
        if let yz = yemekZaman {
            labelDakika.text = yz
        }
        if let y = yemek {
            labelFoodName.text = y.yemek_adi
            labelBirimFiyat.text = "\(y.yemek_fiyat!) ₺"
            labelTotal.text = "₺ \(y.yemek_fiyat!)"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.detailImageView.kf.setImage(with: url)
                }
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        presenterNesnesi?.sepetiYukle(kullanici_adi: kullaniciAdi!)
    }
    func sepetFiyatDegis(){
        if let y = yemek {
            presenterNesnesi?.toplamMiktar(adet: Int(labelSepetAdet.text!)!, birimFiyat: Int(y.yemek_fiyat!)!)
            
        }
    }
    @IBAction func buttonArttir(_ sender: Any) {
        presenterNesnesi?.arttir()
        sepetFiyatDegis()
    }
    @IBAction func buttonAzalt(_ sender: Any) {
        presenterNesnesi?.azalt()
        sepetFiyatDegis()
    }
    @IBAction func buttonSepeteEkle(_ sender: Any) {
        
        if let y = yemek {
            var toplam = Int(labelSepetAdet.text!)
            if let sonYemek = sepetYemekler.first(where: {$0.yemek_adi! == yemek?.yemek_adi!}) {
                presenterNesnesi?.sil(sepet_yemek_id: Int(sonYemek.sepet_yemek_id!)!, kullanici_adi: kullaniciAdi!)
                toplam = Int(sonYemek.yemek_siparis_adet!)! + Int(labelSepetAdet.text!)!
                badgeSayi = sepetYemekler.count
                UtilityFunctions().alertForCart(vc: self, title: "", message: "Ürün Sepetinize Eklendi")
            }else {
                badgeSayi = sepetYemekler.count + 1
            }
            dtm?.badgeSayiGonder(sayi: badgeSayi)
            presenterNesnesi?.sepeteEkle(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: Int(y.yemek_fiyat!)!, yemek_siparis_adet: toplam!, kullanici_adi: kullaniciAdi!)
            UtilityFunctions().alertForCart(vc: self, title: "", message: "Ürün Sepetinize Eklendi")
        }
        
    }
    
    func allDesign() {
        self.tabBarController?.tabBar.isHidden = true
        cnb.customNavBar(navController: navigationController!, subTitle: "", fontSize: 35)
        detailImageView.clipsToBounds = true
        detailImageView.layer.cornerRadius = 20
        detailImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner, ]
        bottomCardView.clipsToBounds = true
        bottomCardView.layer.cornerRadius = 50
        bottomCardView.layer.maskedCorners = [.layerMaxXMinYCorner]
        buttonSepeteEkle.clipsToBounds = true
        buttonSepeteEkle.layer.cornerRadius = 15
        buttonSepeteEkle.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        totalView.clipsToBounds = true
        totalView.layer.cornerRadius = 15
        totalView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
}
extension FoodDetailsPage:FoodDetailsPresenterToViewProtocol {
    func vieweSepetiGonder(foodList: [SepetYemekler]) {
        sepetYemekler = foodList
    }
    
    func toplamMiktariVieweGonder(toplam: Int) {
        labelTotal.text = "₺ \(toplam)"
    }
    
    func vieweVeriGonder(sayi: Int) {
        self.sayi = sayi
        labelSepetAdet.text = "\(sayi)"
    }
}
