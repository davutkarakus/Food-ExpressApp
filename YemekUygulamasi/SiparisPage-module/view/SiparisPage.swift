//
//  SiparisPage.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 23.02.2023.
//

import UIKit
import Lottie
import Firebase
import FirebaseAuth

class SiparisPage: UIViewController {
    private var animationView:LottieAnimationView!
    let user = Auth.auth().currentUser?.displayName
    @IBOutlet weak var buttonAnaSayfayaDon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupdAnimationView()
        buttonAnaSayfayaDon.clipsToBounds = true
        buttonAnaSayfayaDon.layer.cornerRadius = 20
        buttonAnaSayfayaDon.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
    }
    
    @IBAction func buttonAnaSayfayaDon(_ sender: Any) {
        performSegue(withIdentifier: "toMainPage", sender:nil)
    }
    override func updateViewConstraints() {
           self.view.frame.size.height = UIScreen.main.bounds.height - 500
           self.view.frame.origin.y =  450
           self.view.roundCorners(corners: [.topLeft, .topRight], radius: 50.0)
           super.updateViewConstraints()
    }
    func setupdAnimationView() {
        animationView = .init(name:"92163-food-courier")
        animationView.frame = CGRect(x:0, y: 50, width: UIScreen.main.bounds.width, height: 250)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.backgroundColor = UIColor(named: "siparisColor")
        view.addSubview(animationView)
        animationView.play()
    }

}


extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
       let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
   }
}
