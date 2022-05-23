//
//  OfflineViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import CoreData
import Apploader

class OfflineViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var offlineImageTableView: UITableView!
    
    var offlineImages: [ImageDetailEntity] = []
    var alertHud: MBProgressHUD!
    var deleteData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offlineImageTableView.delegate = self
        offlineImageTableView.dataSource = self
        getOfflineImage()
        registerCell()
        configLoader()
        NotificationCenter.default.addObserver(self, selector: #selector(getOfflineImage), name: NSNotification.Name("imageSaved"), object: nil)
    }

    @objc func getOfflineImage(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        let requset: NSFetchRequest<ImageDetailEntity> = ImageDetailEntity.fetchRequest()
        
        do {
            self.offlineImages = try manageedContext.fetch(requset)
            self.offlineImageTableView.reloadData()
            print("the response is: \(offlineImages)")
        } catch {
            print("Error fetching data from context\(error)")
        }
    }
    
    func registerCell(){
        offlineImageTableView.register(UINib(nibName: "OfflineTableViewCell", bundle: nil), forCellReuseIdentifier: "OfflineTableViewCell")
    }
    
    func configLoader() {
        self.alertHud = MBProgressHUD(view: self.view)
        alertHud.bezelView.color = UIColor(red: 53, green: 63, blue: 77, alpha: 1)
        alertHud.bezelView.backgroundColor = .black
        alertHud.contentColor = .white
        alertHud.label.textColor = .white
        self.view.addSubview(self.alertHud)
    }
    
}

extension OfflineViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageLabel.isHidden = !offlineImages.isEmpty
        return offlineImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfflineTableViewCell") as! OfflineTableViewCell
        cell.setup(details: offlineImages[indexPath.row])
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
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
            self.offlineImageTableView.deleteRows(at: [indexPath], with: .automatic)
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
    
    @objc func deleteButtonAction(sender: UIButton) {
        deleteData = sender.tag
        deleteAlertView()
    }
}

extension OfflineViewController {
    func deleteAlertView() {
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
        let yesAction = (UIAlertAction(title: "yes", style: .default, handler:deleteButtonHandler(alerAction:)))
        let NoAction = (UIAlertAction(title: "No", style: .default))
        alert.addAction(yesAction)
        alert.addAction(NoAction)
        self.present(alert, animated: true)
    }
    
    func deleteButtonHandler(alerAction: UIAlertAction){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manageedContext = appdelegate.persistentContainer.viewContext
        do {
            manageedContext.delete(offlineImages[deleteData ?? 0])
            try manageedContext.save()
            offlineImages.remove(at: deleteData ?? 0)
            self.offlineImageTableView.reloadData()
        }
        catch {
            print(error)
        }
    }
    
}
