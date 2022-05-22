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
import Apploader





class ImageCollectionViewCell: UICollectionViewCell, AlertDelegate {

  
    
    @IBOutlet weak var downLoadButton: UIButton!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imgName: String?
    var alertHud: MBProgressHUD!
    var delegate: AlertDelegate?
    
    override func awakeFromNib() {
        configLoader()
    }
    
    func configLoader() {
        self.alertHud = MBProgressHUD(view: self)
        alertHud.bezelView.color = UIColor(red: 53, green: 63, blue: 77, alpha: 1)
        alertHud.bezelView.backgroundColor = .black
        alertHud.contentColor = .white
        alertHud.label.textColor = .white
        self.addSubview(self.alertHud)
    }
       
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        if let img = imageView.image {
            downLoadButton.adjustsImageWhenHighlighted = false
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let manageedContext = appdelegate.persistentContainer.viewContext
            let entityName = ImageDetailEntity(context: manageedContext)
            entityName.img = img.jpegData(compressionQuality: 1.0)
            entityName.imgName = imgName
            do{
                try manageedContext.save()
                delegate?.showAlert(imageSaved: true)
                debugPrint("Image Saved Successfully")
            }
            catch {
                print(error)
            }
            NotificationCenter.default.post(name: NSNotification.Name("imageSaved"), object: nil)
        }
    }
    
    func setup(image: PhotosModel?){
        guard let image = image else {return}
        imageView.kf.setImage(with:(image.urls?.small ?? "").asUrl)
        imageNameLabel.text = image.user?.firstName ?? ""
        self.imgName = image.user?.firstName
    }
    
    func showAlert(imageSaved: Bool){
       if imageSaved {
            self.alertHud.showText(msg: "Image saved to offline",delay: 2)
        }
    }

   
}
