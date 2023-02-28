//
//  UserInfos.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 17.02.2023.
//

import Foundation

class KullaniciBilgi {
    var userEmail:String?
    var userTel:String?
    var userAddress:String?
    init(userEmail: String, userTel: String,  userAddress: String) {
        self.userEmail = userEmail
        self.userTel = userTel
        self.userAddress = userAddress
    }
}
