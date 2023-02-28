//
//  ForgotPasswordPage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 10.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordPage: UIViewController {
    @IBOutlet weak var emailTf: UITextField!
    var cTf = CustomTf()
    var presenterNesnesi:ForgotPwViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        ForgotPasswordRouter.createModule(ref: self)
        cTf.designTf(tf: emailTf, icon: "mailicon")
    }
    @IBAction func buttonSubmit(_ sender: Any) {
        if emailTf.text == "" {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Lütfen E-Mail Adresinizi Giriniz")
        }else {
            presenterNesnesi?.forgotPw(email: emailTf.text!)
        }
    }
    
}

extension ForgotPasswordPage: ForgotPwPresenterToViewProtocol {
    func anyError(bool: Bool) {
        if bool == false {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: "Şifrenizi yenilemek için mail gönderildi!")
            emailTf.text = ""
        }
    }
    
    func vieweVeriGonder(err: Error) {
            UtilityFunctions().simpleAlert(vc: self, title: "", message: err.localizedDescription)
    }
}
