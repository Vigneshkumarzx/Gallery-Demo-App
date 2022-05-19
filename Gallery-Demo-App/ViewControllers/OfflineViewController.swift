//
//  OfflineViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import CoreData

class OfflineViewController: UIViewController {

    var offlineImages: [ImageDetailEntity] = []
    
    @IBOutlet weak var showImage: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OfflineTableViewCell", bundle: nil), forCellReuseIdentifier: "OfflineTableViewCell")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        let requset: NSFetchRequest<ImageDetailEntity> = ImageDetailEntity.fetchRequest()
        
        do {
            self.offlineImages = try manageedContext.fetch(requset)
            print("the response is: \(offlineImages)")
        } catch {
            print("Error fetching data from context\(error)")
        }
    }
}

extension OfflineViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return offlineImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfflineTableViewCell") as! OfflineTableViewCell
        self.tableView.reloadData()
        cell.setup(details: offlineImages[indexPath.row])
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "OfflineImageDetailViewController") as! OfflineImageDetailViewController
        vc.offlineDetails = offlineImages[indexPath.row]
    }
}
