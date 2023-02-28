//
//  FoodCollectionViewCell.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 15.02.2023.
//

import UIKit
protocol HucreProtocol {
    func buttonTiklandi(indexPath:IndexPath,metod:String)
}
class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodYildizLabel: UILabel!
    @IBOutlet weak var foodZamanLabel: UILabel!
    @IBOutlet weak var foodIndirimLabel: UILabel!
    @IBOutlet weak var buttonFavori: UIButton!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    var image = "heart"
    var hucreProtocol:HucreProtocol?
    var method = ""
    var indexPath:IndexPath?
    @IBAction func buttonFavori(_ sender: Any) {
        if buttonFavori.currentImage == UIImage(systemName: "heart") {
            buttonFavori.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            hucreProtocol?.buttonTiklandi(indexPath: indexPath!,metod: "Ekle")
        }else {
            buttonFavori.setImage(UIImage(systemName: "heart"), for: .normal)
            hucreProtocol?.buttonTiklandi(indexPath: indexPath!,metod: "Sil")
        }
        
    }
    
}
