//
//  CartTableViewCell.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 19.02.2023.
//

import UIKit
protocol SepetArttirAzalt {
    func arttirTiklandi(ip:IndexPath)
    func azaltTiklandi(ip:IndexPath)
}
class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var buttonArttirr: UIButton!
    @IBOutlet weak var buttonAzaltt: UIButton!
    @IBOutlet weak var cartFoodPiece: UILabel!
    @IBOutlet weak var cartFoodTotalPrice: UILabel!
    @IBOutlet weak var cartFoodNameLabel: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    var ip:IndexPath?
    var hucreProtocol:SepetArttirAzalt?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonArttir(_ sender: Any) {
        cartFoodPiece.isHidden = true
        progressBar.startAnimating()
        progressBar.isHidden = false
        buttonArttirr.isUserInteractionEnabled = false
        buttonAzaltt.isUserInteractionEnabled = false
        hucreProtocol?.arttirTiklandi(ip: ip!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [self] in
            buttonAzaltt.isUserInteractionEnabled = true
            buttonArttirr.isUserInteractionEnabled = true
            progressBar.isHidden = true
            cartFoodPiece.isHidden = false
            
        }
        
    }
    @IBAction func buttonAzalt(_ sender: Any) {
        progressBar.startAnimating()
        cartFoodPiece.isHidden = true
        progressBar.isHidden = false
        buttonArttirr.isUserInteractionEnabled = false
        buttonAzaltt.isUserInteractionEnabled = false
        hucreProtocol?.azaltTiklandi(ip: ip!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [self] in
            buttonAzaltt.isUserInteractionEnabled = true
            buttonArttirr.isUserInteractionEnabled = true
            progressBar.isHidden = true
            cartFoodPiece.isHidden = false
        }
        
    }
}

