//
//  Image+Extension.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//
import UIKit
import Foundation

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}
