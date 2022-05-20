//
//  Extension + String.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation


extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
