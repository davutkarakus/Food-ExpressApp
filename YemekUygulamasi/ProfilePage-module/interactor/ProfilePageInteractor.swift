//
//  ProfilePageInteractor.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 21.02.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class ProfilePageInteractor : ProfilePresenterToInteractorProtocol {
    var bilgi = [String:String]()
    let ka = Auth.auth().currentUser
    var presenter: ProfileInteractorToPresenterProtocol?
    func downloadPhoto(imageView: UIImageView) {
        let filename = (ka?.email!)! + "_profile_picture.jpeg"
        let path = "images/" + filename
        StorageManager.shared.downloadUrl(for: path, completion: { [self]result in
            switch result {
            case .success(let url):
                print(url)
                self.downloadImage(imageView: imageView, url: url)
            case .failure(let err):
                print("Failed to get download url : \(err)")
            }
        })
    }
    func downloadImage(imageView:UIImageView,url:URL){
        URLSession.shared.dataTask(with: url, completionHandler: {data,_,error in
            guard let data = data , error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
    }
    func getTelAndAddress() {
        var safeEmail = ka?.email!.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail!.replacingOccurrences(of: "@", with: "-")
        let refBilgi = Database.database(url: "https://yemekuygulamasi-6a670-default-rtdb.europe-west1.firebasedatabase.app").reference().child(safeEmail!)
        refBilgi.observe(.value, with: { [self] snapshot in
            if let gelenVeri = snapshot.value as? [String:AnyObject] {
                for veri in gelenVeri {
                    bilgi[veri.key] = veri.value as? String ?? ""
                }
                presenter?.presenteraTelAndAdressGonder(tel:bilgi["user_tel"]! , address: bilgi["user_address"]!)
            }
            else {
                presenter?.presenteraTelAndAdressGonder(tel:"" , address: "")
            }
        })
    }
    
    func uploadPhoto(imageView: UIImageView) {
        guard let image = imageView.image ,let data = image.jpegData(compressionQuality: 0.2) else {
            return
        }
        let fileName = "\(ka!.email!)_profile_picture.jpeg"
        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: {result in
            switch result {
            case .success(let downloadUrl):
                UserDefaults.standard.set(downloadUrl,forKey: "profile_picture_url")
                print(downloadUrl)
            case .failure(let error):
                print("Storage manager error : \(error)")
            }
        })
    }
    func insertUser(tel: String, address: String) {
        DatabaseManager.shared.insertUser(with: KullaniciInfo(tel: tel, address: address, emailAdress: (ka?.email!)!))
    }
    
}
