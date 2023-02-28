//
//  RegisterPage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 8.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterPage: UIViewController{
    
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var confirmPasswordTf: UITextField!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    var presenterNesnesi:RegisterViewToPresenterProtocol?
    var cTf = CustomTf()
    override func viewDidLoad() {
        super.viewDidLoad()
        cTf.designTf(tf: usernameTf, icon: "profil")
        cTf.designTf(tf: emailTf, icon: "mailicon")
        cTf.designTf(tf: passwordTf, icon: "passwordicon")
        cTf.designTf(tf: confirmPasswordTf, icon: "passwordicon")
        RegisterRouter.createModule(ref: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        progressBar.isHidden = true
    }
    @IBAction func buttonSignIn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonSignInInstead(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func buttonSignUp(_ sender: Any) {
        if usernameTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen Kullanıcı Adınızı Giriniz")
        }
       else if emailTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen E-Mail Adresinizi Giriniz")
        }
       else if passwordTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen Şifrenizi Giriniz")
        }
        if confirmPasswordTf.text?.isEmpty == true {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen Şifrenizi Tekrar Giriniz")
        }
        if confirmPasswordTf.text != passwordTf.text {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Şifreniz Eşleşmiyor")
        }
        else {
            self.progressBar.isHidden = false
            self.progressBar.startAnimating()
            presenterNesnesi?.register(email: emailTf.text!, password: passwordTf.text!,username: usernameTf.text!)
        }
    }
}
extension RegisterPage:RegisterPresenterToViewProtocol {
    func vieweVeriGonder(error: Error) {
        progressBar.isHidden = true
        UtilityFunctions().simpleAlert(vc: self, title: "", message: error.localizedDescription)
    }
    
    func anyError(bool: Bool) {
        if bool == false {
            self.dismiss(animated: false,completion: nil)
        }
    }
}

