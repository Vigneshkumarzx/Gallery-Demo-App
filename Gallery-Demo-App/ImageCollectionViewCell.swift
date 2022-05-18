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
            img.toBase64()
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageedContext = appdelegate.persistentContainer.viewContext
            let entityName = ImageDetailEntity.entity()
            
            
            
            
        }
        
        
       
        
    }
    
    func setup(image: PhotosModel?){
        guard let image = image else {return}
        imageView.kf.setImage(with:(image.urls?.small ?? "").asUrl)
        imageNameLabel.text = image.user?.username ?? ""
        imageDescriptionLabel.isHidden = true
//        imageDescriptionLabel.text = image.imageDescription
        let choosenImage = image.urls?.small
    }
    
    func createData(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Entity", in: manageedContext)!
        for i in 1...5{
            let user = NSManagedObject(entity: userEntity, insertInto: manageedContext)
//            user.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        }
    }
   
}

