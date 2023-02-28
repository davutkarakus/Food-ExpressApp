//
//  SplashPage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 11.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class SplashPage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "toOnboarding", sender: nil)
    }
}

