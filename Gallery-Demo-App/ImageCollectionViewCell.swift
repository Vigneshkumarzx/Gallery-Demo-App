//
//  ImageCollectionViewCell.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import Kingfisher
import CoreData
import SwiftUI

class ImageCollectionViewCell: UICollectionViewCell {

  
    
    @IBOutlet weak var downLoadButton: UIButton!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imgName: String?
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        if let img = imageView.image {
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageedContext = appdelegate.persistentContainer.viewContext
            let entityName = ImageDetailEntity(context: manageedContext)
            entityName.img = img.jpegData(compressionQuality: 1.0)
            entityName.imgName = imgName
            do{
                try manageedContext.save()
            }
            catch {
                print(error)
            }
        }
        
        
    }
    
    func setup(image: PhotosModel?){
        guard let image = image else {return}
        imageView.kf.setImage(with:(image.urls?.small ?? "").asUrl)
        imageNameLabel.text = image.user?.username ?? ""
        imageDescriptionLabel.isHidden = true
        self.imgName = image.user?.username
//        imageDescriptionLabel.text = image.imageDescription
        
    }
    

   
}
