//
//  CartPagee.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class CartPagee: UIViewController {
    var sepetBosText:UILabel!
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var buttonSepetiOnayla: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var labelTotalPrice: UILabel!
    var cnb = CustomNavBar()
    var progressBar : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    var cartFoodList = [SepetYemekler]()
    var presenterNesnesi:CartPageViewToPresenterProtocol?
    let user = Auth.auth().currentUser?.email
    override func viewDidLoad() {
        super.viewDidLoad()
        cnb.customNavBar(navController: navigationController!, subTitle: "",fontSize: 35)
        cartTableView.dataSource = self
        cartTableView.delegate = self
        CartPageRouter.createModule(ref: self)
        allDesign()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        addLabel()
        setup()
        sepetBosText.isHidden = true
        progressBar.isHidden = false
        cartTableView.isHidden = true
        presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
        
    }
    func totalPrice() {
        var total = 0
        var t1 = 0
        for f in cartFoodList {
            t1 = Int(f.yemek_fiyat!)! * Int(f.yemek_siparis_adet!)!
            total = t1 + total
        }
        self.labelTotalPrice.text = "₺ \(total)"
    }
    func addLabel() {
        sepetBosText = UILabel(frame: CGRect(x: 0, y: self.view.center.y, width: 290, height: 70))
        sepetBosText.textAlignment = .center
        sepetBosText.font = UIFont(name: "Halvetica", size: 18.0)
        sepetBosText.numberOfLines = 0
        sepetBosText.text = "Sepetinizde ürün bulunmamaktadır."
        sepetBosText.alpha = 0.6
        sepetBosText.lineBreakMode = .byTruncatingTail
        sepetBosText.center = self.view.center
        view.addSubview(sepetBosText!)
    }
    func setup() {
        view.addSubview(progressBar)
        progressBar.center = CGPoint(x: UIScreen.main.bounds.size.width * 0.5, y:UIScreen.main.bounds.size.height * 0.5 )
        progressBar.startAnimating()
    }
    func allDesign() {
        self.tabBarController?.tabBar.isHidden = true
        buttonSepetiOnayla.clipsToBounds = true
        buttonSepetiOnayla.layer.cornerRadius = 15
        buttonSepetiOnayla.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        totalPriceView.clipsToBounds = true
        totalPriceView.layer.cornerRadius = 15
        totalPriceView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
    }
   
    
    @IBAction func buttonSepetiBosalt(_ sender: Any) {
        if cartFoodList.count == 0 {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Sepetiniz zaten boş")
        }else {
            let alert2 = UIAlertController(title: title, message: "Sepeti boşaltmak istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)

            alert2.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { (action) in
                alert2.dismiss(animated: true, completion: nil)
            }))
            alert2.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.destructive, handler: { [self] (action) in
                for f in cartFoodList {
                    self.presenterNesnesi?.sil(sepet_yemek_id: Int(f.sepet_yemek_id!)!, kullanici_adi: user!)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                    presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
                }
            }))
            self.present(alert2, animated: true, completion: nil)
        }
    }
    @IBAction func buttonSepetiOnayla(_ sender: Any) {
        if cartFoodList.count == 0 {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Sepetiniz Boş")
        }else {
            performSegue(withIdentifier: "toSiparis", sender: nil)
        }
        
    }
}
extension CartPagee:UITableViewDelegate,UITableViewDataSource,SepetArttirAzalt {
    func arttirTiklandi(ip:IndexPath) {
       let yemek = cartFoodList[ip.row]
        let adet = Int(yemek.yemek_siparis_adet!)! + 1
        presenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: user!)
        presenterNesnesi?.sepeteEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: adet, kullanici_adi: user!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
            
        }
    }
    
    func azaltTiklandi(ip:IndexPath) {
        let yemek = cartFoodList[ip.row]
        
        let adet = Int(yemek.yemek_siparis_adet!)!
        if adet == 1 {
            let alert2 = UIAlertController(title: "Sil", message: "\(yemek.yemek_adi!) Sepetten Silenecek", preferredStyle: UIAlertController.Style.alert)

            alert2.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { (action) in
                alert2.dismiss(animated: true, completion: nil)
            }))
            alert2.addAction(UIAlertAction(title: "Sil", style: UIAlertAction.Style.destructive, handler: { [self] (action) in
                self.presenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: user!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                    presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
                }
            }))
            self.present(alert2, animated: true, completion: nil)
        }else {
            self.presenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: user!)
            self.presenterNesnesi?.sepeteEkle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: adet - 1, kullanici_adi: user!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hucre = tableView.dequeueReusableCell(withIdentifier: "cartFoodCell") as! CartTableViewCell
        let food = cartFoodList[indexPath.row]
        hucre.cartFoodNameLabel.text = food.yemek_adi
        hucre.cartFoodPiece.text = "\(food.yemek_siparis_adet!)"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                hucre.cartImageView.kf.setImage(with: url)
            }
        }
        hucre.progressBar.isHidden = true
        hucre.hucreProtocol = self
        hucre.ip = indexPath
        hucre.cartFoodTotalPrice.text = "\(Int(food.yemek_siparis_adet!)! * Int(food.yemek_fiyat!)!) ₺"
        hucre.selectionStyle = .none
        return hucre
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,Bool) in
            let food = self.cartFoodList[indexPath.row]
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(food.yemek_adi!) Silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ [self]action in
                self.presenterNesnesi?.sil(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: user!)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                    presenterNesnesi?.sepetiYukle(kullanici_adi: user!)
                }
            }
            alert.addAction(evetAction)
            self.present(alert,animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
extension CartPagee:CartPagePresenterToViewProtocol {
    func vieweVeriGonder(foodList: [SepetYemekler]) {
        self.cartFoodList = foodList
        if cartFoodList.count == 0 {
            sepetBosText.isHidden = false
            cartTableView.isHidden = true
        }else {
            cartTableView.isHidden = false
            sepetBosText.isHidden = true
        }
        DispatchQueue.main.async { [self] in
            cartTableView.reloadData()
            totalPrice()
            cartTableView.isHidden = false
            progressBar.isHidden = true
        }
    }
    
    
}
