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

    @IBOutlet weak var imageId: UILabel!
    
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var imageDetails: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        imageDescription.numberOfLines = 0
    }
    private func populateView(){
        imageView.kf.setImage(with: details.urls?.full?.asUrl,placeholder: UIImage(named: "placeHolder"))
        imageNameLabel.text = details.user?.name
        imageDescription.text = details.user?.bio
        userIdLabel.text = details.user?.id
        if (details.user?.bio != nil){
            imageDetails.isHidden = false
        } else{
            imageDetails.isHidden = true
        }
        if(details.user?.name != nil){
            imageName.isHidden = false
        }else if(details.user?.id != nil) {
            imageId.isHidden = false
        }else {
            imageDetails.isHidden = true
            imageId.isHidden = true
            imageName.isHidden = true
        }
    }
    
}


