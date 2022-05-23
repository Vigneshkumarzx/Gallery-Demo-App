//
//  OfflineTableViewCell.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import CoreData
import Kingfisher

class OfflineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offlineImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    var deleteImages: NSManagedObject!
    
    func setup(details: ImageDetailEntity) {
        
        if let data = details.img {
            offlineImage.image = UIImage(data: data)
        }
        deleteImages = details
        
    }
   
       
}
