//
//  OnboardingCollectionViewCell.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 26.02.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
        @IBOutlet weak var slideImageView: UIImageView!
        @IBOutlet weak var slideTitleLbl: UILabel!
        @IBOutlet weak var slideDescriptionLbl: UILabel!
        
        func setup(_ slide: OnboardingSlide) {
            slideImageView.image = slide.image
            slideTitleLbl.text = slide.title
            slideDescriptionLbl.text = slide.description
        }
}

