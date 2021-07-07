//
//  UIColorHex.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

func Color(num: Int = 0) -> UIColor{
    if num == 0 {
        return UIColor(hex: "f2f2f2")
    }else if( num == 1){
        return UIColor(hex: "07889b")
    }else if( num == 2){
        return UIColor(hex: "66b9bf")
    }else {
        return UIColor(hex: "eeaa7b")
    }
        
}
