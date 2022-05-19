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
        cell.setup(details: offlineImages[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
//        cell.deleteImages = offlineImages[indexPath.row]
       
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "OfflineImageDetailViewController") as! OfflineImageDetailViewController
        vc.offlineDetails = offlineImages[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.offlineImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        deleteAction.image = UIImage(named: "deletebin")
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { _, _  in
            self.offlineImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    @objc func deleteButtonAction(sender: UIButton) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        do {
            manageedContext.delete(offlineImages[sender.tag])
            try manageedContext.save()
            offlineImages.remove(at: sender.tag)
            self.tableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
}

