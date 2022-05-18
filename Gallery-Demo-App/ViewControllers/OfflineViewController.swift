//
//  OfflineViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import CoreData

class OfflineViewController: UIViewController {

    var offlineImages: ImageDetailEntity?
    
    @IBOutlet weak var showImage: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func showImageButtonTapped(_ sender: Any) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        let entityName = ImageDetailEntity(context: manageedContext)
       let  offlineImages = ImageDetailEntity.fetchRequest()  as! NSFetchRequest<ImageDetailEntity>
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: offlineImages) { result in
//            success(result.finalResult ?? [])
            print(result)
            
        }
        
    
        
        
    }

   
}
