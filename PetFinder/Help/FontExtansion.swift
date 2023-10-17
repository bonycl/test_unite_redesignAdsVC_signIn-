//
//  FontExtansion.swift
//  PetFinder
//
//  Created by Julia on 17.10.2023.
//

import UIKit

extension UIFont {
    enum Montseratt: String {
        case bold = "Montserrat-Bold"
        case light = "Montserrat-Light"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"
        case semibold = "Montserrat-Semibold"
    }
    class func montseratt(ofSize fontSize: CGFloat, weight: Montseratt) -> UIFont {
        return UIFont(name: weight.rawValue, size: fontSize) ?? systemFont(ofSize: 16)
    }
}
