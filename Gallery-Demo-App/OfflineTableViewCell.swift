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

    var deleteImages: NSManagedObject!
    @IBOutlet weak var offlineImageView: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    func setup(details: ImageDetailEntity) {
        
        if let data = details.img {
            offlineImageView.image = UIImage(data: data)
        }
        deleteImages = details
    }
   
       
}
