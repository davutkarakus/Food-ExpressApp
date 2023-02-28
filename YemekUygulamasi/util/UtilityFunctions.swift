//
//  UtilityFunctions.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 10.02.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class UtilityFunctions : NSObject {
    func simpleAlert(vc:UIViewController,title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default,handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true,completion: nil)
        
    }
    func alertForCart(vc:UIViewController,title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default,handler: { action in
            vc.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        vc.present(alert, animated: true,completion: nil)
        
    }
    func deleteAlert (vc:UIViewController,title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert2.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert2.dismiss(animated: true, completion: nil)
        }))
        alert2.addAction(UIAlertAction(title: "Sil", style: UIAlertAction.Style.destructive, handler: { (action) in
            let user = Auth.auth().currentUser

            user?.delete { error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    vc.performSegue(withIdentifier: "backLogin", sender: nil)
                }
            }
            let desertRef = StorageReference().child("images/" + (user?.email!)! + "_profile_picture.jpeg")
            desertRef.delete {error in
                if let err = error {
                    print(err.localizedDescription)
                }else {
                    print("başarılı")
                }
            }
            var safeEmail = user?.email!.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail!.replacingOccurrences(of: "@", with: "-")
            let ref = Database.database(url: "https://yemekuygulamasi-6a670-default-rtdb.europe-west1.firebasedatabase.app").reference().child(safeEmail!)
            ref.removeValue()
        }))
        vc.present(alert2, animated: true, completion: nil)
}
    func logOutAlert (vc:UIViewController,title:String, message:String){
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert2.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert2.dismiss(animated: true, completion: nil)
        }))
        alert2.addAction(UIAlertAction(title: "Çıkış Yap", style: UIAlertAction.Style.destructive, handler: { (action) in
            do {
                try Auth.auth().signOut(); vc.performSegue(withIdentifier: "backLogin", sender: nil)
                
            } catch let signOutError {
                UtilityFunctions().simpleAlert(vc: vc, title: "", message: signOutError.localizedDescription)
            }
        }))
        vc.present(alert2, animated: true, completion: nil)
}
/*    func changePasswordAlert(vc:UIViewController,title:String, message:String) {
        let alert2 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert2.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert2.dismiss(animated: true, completion: nil)
        }))
        alert2.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.destructive, handler: { (action) in
            let user = Auth.auth().currentUser

            user?.updatePassword(to: <#T##String#>) { error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                } else {
                    vc.performSegue(withIdentifier: "backLogin", sender: nil)
                }
            }
        }))
        vc.present(alert2, animated: true, completion: nil)
    }
 */
}
