//
//  CustomTf.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 13.02.2023.
//

import Foundation
import UIKit

class CustomTf {
    func designTf(tf:UITextField,icon:String) {
        let bottomline1 = CALayer()
        bottomline1.frame = CGRect(x: 0, y: tf.frame.height - 1, width: tf.frame.width, height: 1.0)
        bottomline1.backgroundColor =  UIColor.darkGray.cgColor
        tf.borderStyle = UITextField.BorderStyle.none
        tf.layer.addSublayer(bottomline1)
        tf.setupLeftSideImage(ImageViewNamed: icon)
    }
}
