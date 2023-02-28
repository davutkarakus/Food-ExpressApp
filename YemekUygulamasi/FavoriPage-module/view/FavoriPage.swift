//
//  FavoriPage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 16.02.2023.
//

import UIKit

class FavoriPage: UIViewController {
    var cnb = CustomNavBar()
    var favoriList = [FavoriYemekler]()
    var presenterNesnesi:FavoriViewToPresenterProtocol?
    @IBOutlet weak var favoriFoodCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cnb.customNavBar(navController: navigationController!, subTitle: "", fontSize: 35)
        favoriFoodCollectionView.delegate = self
        favoriFoodCollectionView.dataSource = self
        FavoriRouter.createModule(ref: self)
        
        collectionViewTasarim()
        
        veritabaniKopyala()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presenterNesnesi?.favoriYukle()
        
    }
    func collectionViewTasarim() {
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10

        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30)/2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.7)
        favoriFoodCollectionView.collectionViewLayout = tasarim
    }
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "FavoriYemekler", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("FavoriYemekler.sqlite")
        
        let fm = FileManager.default
        if fm.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var")
        }else{
            do{
                try fm.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
extension FavoriPage:UICollectionViewDelegate,UICollectionViewDataSource,FavoriHucreProtocol{
    func buttonTiklandi(indexPath: IndexPath) {
        let yemek = favoriList[indexPath.row]
        self.presenterNesnesi?.sil(yemek_id: yemek.yemek_id!)
        presenterNesnesi?.favoriYukle()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekFavoriHucre", for: indexPath) as! FavoriCollectionViewCell
        let yemek = favoriList[indexPath.row]
        hucre.favoFoodNameLabel.text = yemek.yemek_ad
        hucre.favoFoodPriceLabel.text = "\(yemek.yemek_fiyat!) ₺"
        hucre.favoFoodYildiz.text = yemek.yemek_yildiz
        hucre.favoFoodIndirim.text = yemek.yemek_indirim
        hucre.favoFoodZaman.text = yemek.yemek_zaman
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim!)") {
            DispatchQueue.main.async {
                hucre.favoFoodImageVieww.kf.setImage(with: url)
            }
        }
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10
        hucre.indexPath = indexPath
        hucre.favorihucreProtocol = self
        return hucre
    }    

}
extension FavoriPage : FavoriPresenterToViewProtocol {
    func vieweVeriGonder(favoriList: [FavoriYemekler]) {
        self.favoriList = favoriList
        self.favoriFoodCollectionView.reloadData()
    }

}
