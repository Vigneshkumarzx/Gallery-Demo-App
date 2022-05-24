//
//  OfflineImageDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit

class OfflineImageDetailViewController: UIViewController {
    
    @IBOutlet weak var offlineDetailImageView: UIImageView!
    var offlineDetails: ImageDetailEntity!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func popUpview() {
        if let data = offlineDetails.img {
            offlineDetailImageView.image = UIImage(data: data)
        }
    }
}
