//
//  UIColor+Extensions.swift
//  rtbbamap_sample
//
//  Created by Rizal Hilman on 09/09/24.
//

import UIKit

extension UIColor {
    static var myStrokeColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return UIColor.black
        }
    }
}
