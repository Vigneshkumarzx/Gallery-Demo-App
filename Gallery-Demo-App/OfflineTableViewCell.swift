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
    
    func setup(details: ImageDetailEntity) {
        
        if let data = details.img {
            offlineImageView.image = UIImage(data: data)
        }
        deleteImages = details
        
    }
   
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        do {
            manageedContext.delete(deleteImages)
            try manageedContext.save()
        }
        catch {
            print(error)
        }
    }
    
}
