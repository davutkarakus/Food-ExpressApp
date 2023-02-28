//
//  LoginUI.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 8.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginPage: UIViewController {
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    var presenterNesnesi:LoginViewToPresenterProtocol?
    
    var cTf = CustomTf()
    override func viewDidLoad() {
        super.viewDidLoad()
        cTf.designTf(tf: usernameTf, icon: "mailicon")
        cTf.designTf(tf: passwordTf, icon: "passwordicon")
        LoginRouter.createModule(ref: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        progressBar.isHidden = true
    }
    @IBAction func buttonForgotPassword(_ sender: Any) {
        performSegue(withIdentifier: "toForgot", sender: nil)
    }
    @IBAction func buttonSignIn(_ sender: Any) {
        if usernameTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen E-Mail Adresinizi Giriniz")
        }
        else if passwordTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen Şifrenizi Giriniz")
            
        }else {
            self.progressBar.isHidden = false
            self.progressBar.startAnimating()
            presenterNesnesi?.login(email: usernameTf.text!, password: passwordTf.text!)
        }
    }
    @IBAction func buttonSignUp(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    @IBAction func buttonCreateAccount(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
   
}
extension UITextField{
    func setupLeftSideImage (ImageViewNamed : String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: ImageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageViewContainerView.addSubview(imageView)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
        
    }
}
extension LoginPage:LoginPresenterToViewProtocol {
    func isLogin(user: Bool) {
        if user {
            self.performSegue(withIdentifier: "toMain", sender: nil)
            self.usernameTf.text = ""
            self.passwordTf.text = ""
        }
    }
    
    func vieweVeriGonder(err: Error) {
        self.progressBar.isHidden = true
        UtilityFunctions().simpleAlert(vc: self, title: "", message: err.localizedDescription)
    }
    
    
}

