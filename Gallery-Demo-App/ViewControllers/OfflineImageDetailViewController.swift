//
//  OfflineImageDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit

class OfflineImageDetailViewController: UIViewController {
    
    var offlineDetails: ImageDetailEntity!

    @IBOutlet weak var offlineDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func popUpview(){
        
        if let data = offlineDetails.img {
            offlineDetailImageView.image = UIImage(data: data)
        }
        
    }
}
