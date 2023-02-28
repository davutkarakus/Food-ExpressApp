//
//  ViewController.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 8.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

class MainPage: UIViewController ,DetailsToMainProtocol{
    func badgeSayiGonder(sayi: Int) {
        cartItem.updateBadge(number: sayi)
    }
    var progressBar : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cartItem: UIBarButtonItem!
    @IBOutlet weak var foodsCollentionView: UICollectionView!
    var favoriListesi = [FavoriYemekler]()
    var badgeSayi = 0
    var cnb = CustomNavBar()
    var foodList = [Yemekler]()
    var yemekExtraBilgi = [YemekEkstraBilgiler]()
    var indexPath:IndexPath?
    var presenterNesnesi:MainViewToPresenterProtocol?
    let user = Auth.auth().currentUser?.email
    let detailsPage = FoodDetailsPage()
    let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EkstraBilgiler()
        CollectionViewTasarim()
        addProfilePhoto()
        
        cnb.customNavBar(navController: navigationController!, subTitle: "Hoşgeldiniz",fontSize: 35)
        
        foodsCollentionView.delegate = self
        foodsCollentionView.dataSource = self
        MainPageRouter.createModule(ref: self)
        searchBar.delegate = self
        
        self.searchBar.backgroundImage = UIImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        progressBar.isHidden = false
        foodsCollentionView.isHidden = true
        veritabaniKopyala()
        cnb.customNavBar(navController: navigationController!, subTitle: "Hoşgeldiniz",fontSize: 35)
        self.tabBarController?.tabBar.isHidden = false
        presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
        presenterNesnesi?.uploadImage(imageView: imageview)
        presenterNesnesi?.yemekleriYukle()
        presenterNesnesi?.favoriYukle()
    }
    func CollectionViewTasarim() {
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30)/2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.7)
        foodsCollentionView.collectionViewLayout = tasarim
    }
    func setup() {
        view.addSubview(progressBar)
        progressBar.center = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y:UIScreen.main.bounds.size.height * 0.5 )
        progressBar.startAnimating()
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
    func addProfilePhoto() {
                        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                        imageview.image = UIImage(named: "profil")
                        imageview.backgroundColor = .white
                        imageview.contentMode = UIView.ContentMode.scaleAspectFill
                        imageview.layer.cornerRadius = 20
                        imageview.layer.masksToBounds = true
                        containView.addSubview(imageview)
                        self.presenterNesnesi?.uploadImage(imageView: imageview)
                        let leftbar = UIBarButtonItem(customView: containView)
                        self.navigationItem.leftBarButtonItem = leftbar
    }
    
}



extension MainPage:MainPresenterToViewProtocol {
    func vieweFavoriGonder(favoriList: [FavoriYemekler]) {
        favoriListesi = favoriList
    }
    
    func vieweSepetiGonder(liste: [SepetYemekler]) {
        badgeSayi = liste.count
        cartItem.addBadge(number: badgeSayi)
    }
    
    func vieweVeriGonder(yemekListesi: [Yemekler]) {
        
        self.foodList = yemekListesi
        DispatchQueue.main.async { [self] in
            
            self.foodsCollentionView.reloadData()
            foodsCollentionView.isHidden = false
            progressBar.isHidden = true
        }
    }
    
    
}
extension MainPage : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            presenterNesnesi?.yemekleriYukle()
        }else {
            presenterNesnesi?.ara(aramaKelimesi: searchText)
        }
    }
}

extension MainPage:UICollectionViewDelegate,UICollectionViewDataSource ,HucreProtocol{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! FoodCollectionViewCell
        let yemek = foodList[indexPath.row]
        let yeb = yemekExtraBilgi[indexPath.row]
        hucre.foodNameLabel.text = yemek.yemek_adi
        hucre.foodPrice.text = "\(yemek.yemek_fiyat!) ₺"
        hucre.foodIndirimLabel.text = yeb.yemek_indirim
        hucre.foodZamanLabel.text = yeb.yemek_zaman
        hucre.foodYildizLabel.text = yeb.yemek_yildiz
        if favoriListesi.first(where: {$0.yemek_ad == yemek.yemek_adi!}) != nil {
            hucre.buttonFavori.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else {
            hucre.buttonFavori.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                hucre.foodImageView.kf.setImage(with: url)
            }
        }
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10
        hucre.hucreProtocol = self
        hucre.indexPath = indexPath
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "toDetay", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
                let gidilecekVC = segue.destination as! FoodDetailsPage
            gidilecekVC.dtm = self
            gidilecekVC.yemek = foodList[indexPath!.row]
            gidilecekVC.yemekZaman = yemekExtraBilgi[indexPath!.row].yemek_zaman
        }
    }
    
    func buttonTiklandi(indexPath: IndexPath, metod: String) {
        let yemek = foodList[indexPath.row]
        let yeb = yemekExtraBilgi[indexPath.row]
        if metod == "Ekle" {
            print("Eklendi")
            presenterNesnesi?.favoriKaydet(kullanici_ad: user!, yemek_ad: yemek.yemek_adi!, yemek_resim: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_yildiz: yeb.yemek_yildiz!, yemek_zaman: yeb.yemek_zaman!, yemek_indirim: yeb.yemek_indirim!)
        }else {
            print("Silindi")
            let yemek = foodList[indexPath.row]
            self.presenterNesnesi?.sil(yemek_ad: yemek.yemek_adi!)
        }
    
    }
}
