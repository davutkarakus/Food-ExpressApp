//
//  CustomNavBar.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 13.02.2023.
//

import Foundation
import UIKit

class CustomNavBar {
    
    func customNavBar(navController:UINavigationController,subTitle:String,fontSize:Int){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "anaRenk")
        appearance.titleTextAttributes = [.foregroundColor:UIColor.white,.font:UIFont(name: "BubblegumSans-Regular", size: CGFloat(fontSize))!]
        appearance.titlePositionAdjustment = .init(
           horizontal: 0,
           vertical: 5
        )
        navController.navigationBar.layer.borderWidth = 0.6
        navController.navigationBar.layer.borderColor = UIColor(named: "anaRenk")?.cgColor
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        let shadowView = UIView(frame: CGRect(x: 0, y: (navController.navigationBar.bounds.maxY), width: (navController.navigationBar.bounds.width), height: 30))
            shadowView.backgroundColor = .clear
        let subtitle = UILabel(frame: CGRect(x:0, y: -10, width: UIScreen.main.bounds.width, height: 50))
        subtitle.textAlignment = .center
        subtitle.text = subTitle
        subtitle.textColor = UIColor.white
        subtitle.font = UIFont(name: "BubblegumSans-Regular", size: 15)
        shadowView.addSubview(subtitle)
        navController.navigationBar.addSubview(shadowView)
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 30, height: 30)).cgPath
            shadowLayer.fillColor = UIColor(named: "anaRenk")?.cgColor
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            // This too you can set as per your desired result
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 4.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            shadowView.layer.insertSublayer(shadowLayer, at: 0)
    }
}
