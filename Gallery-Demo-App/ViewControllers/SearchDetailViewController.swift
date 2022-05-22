//
//  SearchDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import Kingfisher

class SearchDetailViewController: UIViewController {
    
   
    
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
        detailsImageView.kf.setImage(with: searchDetail.urls?.small?.asUrl)
        imageDeslabel.text = searchDetail.user?.username
        imageBioLabel.text = searchDetail.user?.bio
        imageNameLabel.text = searchDetail.user?.firstName
    }
}
