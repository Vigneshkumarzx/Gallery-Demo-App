//
//  ImageDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    var details: PhotosModel!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        
    }
    private func populateView(){
        imageView.kf.setImage(with: details.urls?.small?.asUrl)
        imageName.text = details.user?.name
        imageDescription.text = details.user?.bio
        userIdLabel.text = details.user?.id
    }
    
}
