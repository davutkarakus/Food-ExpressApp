//
//  YemekEkstraBilgiler.swift
//  YemekUygulamasi
//
//  Created by Davut Karakuş on 18.02.2023.
//

import Foundation

class YemekEkstraBilgiler {
    var yemek_yildiz:String?
    var yemek_indirim:String?
    var yemek_zaman:String?
    
    init(yemek_yildiz: String, yemek_indirim: String, yemek_zaman: String) {
        self.yemek_yildiz = yemek_yildiz
        self.yemek_indirim = yemek_indirim
        self.yemek_zaman = yemek_zaman
    }
    
}
extension MainPage {
    func EkstraBilgiler() {
        let b1 = YemekEkstraBilgiler(yemek_yildiz: "4.5", yemek_indirim: "%15 indirim", yemek_zaman: "10-15 dk")
        let b2 = YemekEkstraBilgiler(yemek_yildiz: "4.6", yemek_indirim: "%25 indirim", yemek_zaman: "20-25 dk")
        let b3 = YemekEkstraBilgiler(yemek_yildiz: "4.2", yemek_indirim: "%20 indirim", yemek_zaman: "10-15 dk")
        let b4 = YemekEkstraBilgiler(yemek_yildiz: "4.3", yemek_indirim: "%10 indirim", yemek_zaman: "30-35 dk")
        let b5 = YemekEkstraBilgiler(yemek_yildiz: "4.4", yemek_indirim: "%25 indirim", yemek_zaman: "35-40 dk")
        let b6 = YemekEkstraBilgiler(yemek_yildiz: "4.1", yemek_indirim: "%15 indirim", yemek_zaman: "20-25 dk")
        let b7 = YemekEkstraBilgiler(yemek_yildiz: "3.5", yemek_indirim: "%5 indirim", yemek_zaman: "25-30 dk")
        let b8 = YemekEkstraBilgiler(yemek_yildiz: "4.1", yemek_indirim: "%35 indirim", yemek_zaman: "30-35 dk")
        let b9 = YemekEkstraBilgiler(yemek_yildiz: "4.2", yemek_indirim: "%10 indirim", yemek_zaman: "20-25 dk")
        let b10 = YemekEkstraBilgiler(yemek_yildiz: "3.7", yemek_indirim: "%15 indirim", yemek_zaman: "30-35 dk")
        let b11 = YemekEkstraBilgiler(yemek_yildiz: "2.5", yemek_indirim: "%25 indirim", yemek_zaman: "40-45 dk")
        let b12 = YemekEkstraBilgiler(yemek_yildiz: "4.7", yemek_indirim: "%20 indirim", yemek_zaman: "10-15 dk")
        let b13 = YemekEkstraBilgiler(yemek_yildiz: "4.9", yemek_indirim: "%10 indirim", yemek_zaman: "15-20 dk")
        let b14 = YemekEkstraBilgiler(yemek_yildiz: "4.2", yemek_indirim: "%5 indirim", yemek_zaman: "10-15 dk")
        yemekExtraBilgi.append(b1)
        yemekExtraBilgi.append(b2)
        yemekExtraBilgi.append(b3)
        yemekExtraBilgi.append(b4)
        yemekExtraBilgi.append(b5)
        yemekExtraBilgi.append(b6)
        yemekExtraBilgi.append(b7)
        yemekExtraBilgi.append(b8)
        yemekExtraBilgi.append(b9)
        yemekExtraBilgi.append(b10)
        yemekExtraBilgi.append(b11)
        yemekExtraBilgi.append(b12)
        yemekExtraBilgi.append(b13)
        yemekExtraBilgi.append(b14)
    }
}
