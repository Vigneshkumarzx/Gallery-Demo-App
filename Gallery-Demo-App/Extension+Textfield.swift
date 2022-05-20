//
//  Extension+Textfield.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 20/05/22.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let IconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        IconContainerView.addSubview(iconView)
        leftView = IconContainerView
        leftViewMode = .always
    }
}

