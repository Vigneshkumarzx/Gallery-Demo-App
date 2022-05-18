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
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        if let img = imageView.image {
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageedContext = appdelegate.persistentContainer.viewContext
            let entityName = ImageDetailEntity(context: manageedContext)
            entityName.img = img.pngData()
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
//        imageDescriptionLabel.text = image.imageDescription
        
    }
    

   
}

