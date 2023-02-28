//
//  ProfilePage.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 13.02.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ProfilePage: UIViewController {
    var cnb = CustomNavBar()
    var oldPass:String = ""
    var newPass:String = ""
    var kullanici:KullaniciBilgi?
    
    @IBOutlet weak var hesabiSilButton: UIButton!
    @IBOutlet weak var cikisYapButton: UIButton!
    @IBOutlet weak var sifreDegistirButton: UIButton!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var telTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var usernameTf: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var presenterNesnesi : ProfileViewToPresenterProtocol?
    let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        navTasarim()
        
        ProfilePageRouter.createModule(ref: self)
        
        emailTf.text = user?.email
        usernameTf.text = user?.displayName
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        isHidden(bool: true)
        presenterNesnesi?.getTelAndAddress()
        presenterNesnesi?.downloadPhoto(imageView: imageView)
    }
    func isHidden(bool:Bool) {
        progressBar.isHidden = !bool
        progressBar.startAnimating()
        telTf.isHidden = bool
        addressTf.isHidden = bool
        emailTf.isHidden = bool
        usernameTf.isHidden = bool
        imageView.isHidden = bool
        hesabiSilButton.isHidden = bool
        cikisYapButton.isHidden = bool
        sifreDegistirButton.isHidden = bool
        plusImage.isHidden = bool
    }
    func navTasarim() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        appearance.backgroundColor = UIColor(named: "anaRenk")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    @IBAction func buttonLogout(_ sender: Any) {
        UtilityFunctions().logOutAlert(vc: self, title: "", message: "Çıkış yapmak istediğinize emin misiniz?")
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        if addressTf.text == "" {
            UtilityFunctions().simpleAlert(vc: self, title: "Hata", message: "Lütfen adresinizi giriniz.")
        }
        else if telTf.text == "" {
            UtilityFunctions().simpleAlert(vc: self, title: "Hata", message: "Lütfen telefon numaranızı giriniz.")
        }else {
            presenterNesnesi?.uploadPhoto(imageView: imageView)
            presenterNesnesi?.insertUser(tel: telTf.text!, address: addressTf.text!)
        }
       
    }
    
    @IBAction func buttonChangePassword(_ sender: Any) {
        let addAlertView = UIAlertController(title: "Şifre", message: "Şifrenizi giriniz", preferredStyle: UIAlertController.Style.alert)
            addAlertView.addAction(UIAlertAction(title: "İptal",
                                                 style: UIAlertAction.Style.default,
                                                 handler: nil))
            addAlertView.addAction(UIAlertAction(title: "Tamam",
                                                 style: UIAlertAction.Style.default,
                                                 handler:  { [self] (action) in
                let user = Auth.auth().currentUser
                let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPass)
                user?.reauthenticate(with: credential, completion: { [self] (result, error) in
                    if let error = error {
                        UtilityFunctions().simpleAlert(vc: self, title: "", message: error.localizedDescription)
                    }else{
                        // Update //
                        let alert2 = UIAlertController(title: "", message: "Şifremi değiştir", preferredStyle: UIAlertController.Style.alert)
                        
                        alert2.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { (action) in
                            alert2.dismiss(animated: true, completion: nil)
                        }))
                        
                        alert2.addAction(UIAlertAction(title: "Kaydet", style: UIAlertAction.Style.default, handler: { [self] (action) in
                            let user = Auth.auth().currentUser
                            user?.updatePassword(to:newPass) { error in
                                if error != nil {
                                    UtilityFunctions().simpleAlert(vc: self, title: "", message: error!.localizedDescription)
                                } else {
                                    UtilityFunctions().simpleAlert(vc: self, title: "", message: "Başarılı")
                                }
                            }
                        }))
                        alert2.addTextField(configurationHandler: {(textField:UITextField) in
                            textField.placeholder = "Yeni şifrenizi giriniz"
                            textField.isSecureTextEntry = true
                            textField.addTarget(self, action: #selector(self.textChanged1(_:)),for: .editingChanged)
                        })
                        self.present(alert2, animated: true, completion: nil)
                    }
                })
                
            }))

        addAlertView.addTextField(configurationHandler: {(textField:UITextField) in
            textField.placeholder = "Şifre"
            textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(self.textChanged(_:)),for: .editingChanged)
        })
        
        self.present(addAlertView, animated: true, completion: nil)
    }
    
    @IBAction func buttonDeleteAccount(_ sender: Any) {
        let addAlertView = UIAlertController(title: "Şifre", message: "Şifrenizi giriniz ", preferredStyle: UIAlertController.Style.alert)
            addAlertView.addAction(UIAlertAction(title: "İptal",
                                                 style: UIAlertAction.Style.default,
                                                 handler: nil))

            addAlertView.addAction(UIAlertAction(title: "Tamam",
                                                 style: UIAlertAction.Style.default,
                                                 handler:  { [self] (action) in
                let user = Auth.auth().currentUser
                let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPass)
                user?.reauthenticate(with: credential, completion: { [self] (result, error) in
                    if let error = error {
                        UtilityFunctions().simpleAlert(vc: self, title: "", message: error.localizedDescription)
                    }else{
                        UtilityFunctions().deleteAlert(vc: self, title: "Hesabı Sil", message: "Hesabınızı  silmek istediğinize emin misiniz? Kalıcı olarak silinecektir.")
                    }
                })
                
            }))

        addAlertView.addTextField(configurationHandler: {(textField:UITextField) in
            textField.placeholder = "Şifre"
            textField.isSecureTextEntry = true
            textField.addTarget(self, action: #selector(self.textChanged(_:)),for: .editingChanged)
        })
        
        self.present(addAlertView, animated: true, completion: nil)
    }
    @objc func textChanged(_ sender:UITextField) {
            oldPass = sender.text!
    }
    @objc func textChanged1(_ sender:UITextField) {
        newPass = sender.text!
    }
    
}
extension ProfilePage:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension ProfilePage : ProfilePresenterToViewProtocol {
    func vieweTelAndAdressGonder(tel: String, address: String) {
        self.telTf.text = tel
        self.addressTf.text = address
        isHidden(bool: false)
    }

}
