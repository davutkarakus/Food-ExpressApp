//
//  DatabaseManager.swift
//  FoodExpress
//
//  Created by Davut Karakuş on 23.02.2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://yemekuygulamasi-6a670-default-rtdb.europe-west1.firebasedatabase.app").reference()
}
extension DatabaseManager {
    public func insertUser(with user: KullaniciInfo) {
        database.child(user.safeEmail).setValue([
            "user_tel":user.tel ,
            "user_address":user.address
        ])
    }
}
struct KullaniciInfo {
    let tel:String
    let address:String
    let emailAdress:String
    var safeEmail:String {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
