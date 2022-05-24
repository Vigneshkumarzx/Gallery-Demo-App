//
//  UIView+Extension.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 20/05/22.
//

import Foundation
import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
