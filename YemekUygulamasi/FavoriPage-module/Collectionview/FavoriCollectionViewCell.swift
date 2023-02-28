//
//  FavoriCollectionViewCell.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import UIKit
protocol FavoriHucreProtocol {
    func buttonTiklandi(indexPath:IndexPath)
}
class FavoriCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonFavori: UIButton!
    @IBOutlet weak var favoFoodIndirim: UILabel!
    @IBOutlet weak var favoFoodZaman: UILabel!
    @IBOutlet weak var favoFoodYildiz: UILabel!
    @IBOutlet weak var favoFoodImageVieww: UIImageView!
    @IBOutlet weak var favoFoodNameLabel: UILabel!
    @IBOutlet weak var favoFoodPriceLabel: UILabel!
    var indexPath:IndexPath?
    var favorihucreProtocol:FavoriHucreProtocol?
    @IBAction func favoriButton(_ sender: Any) {
        favorihucreProtocol?.buttonTiklandi(indexPath: indexPath!)
    }
}
