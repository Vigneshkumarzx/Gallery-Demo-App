//
//  SearchDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import Kingfisher

class SearchDetailViewController: UIViewController {
    
    @IBOutlet weak var imgDetail: UILabel!
    @IBOutlet weak var imgName: UILabel!
    @IBOutlet weak var imageId: UILabel!
    @IBOutlet weak var imageBioLabel: UILabel!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var imageDeslabel: UILabel!
    var searchDetail: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView()
   }
    func popUpView(){
        detailsImageView.kf.setImage(with: searchDetail.urls?.full?.asUrl)
        imageDeslabel.text = searchDetail.user?.id
        imageBioLabel.text = searchDetail.user?.bio
        imageNameLabel.text = searchDetail.user?.firstName
        if searchDetail.user?.id != nil {
            imageId.isHidden = false
        }else {
            imageId.isHidden = true
        }
        if searchDetail.user?.bio != nil {
            imgDetail.isHidden = false
        }else {
            imgDetail.isHidden = true
        }
        if searchDetail.user?.firstName != nil {
            imgName.isHidden = false
        }else {
            imgName.isHidden = true
        }
    }
}
