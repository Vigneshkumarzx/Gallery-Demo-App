//
//  SearchDetailViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import UIKit
import Kingfisher

class SearchDetailViewController: UIViewController {
    
    var searchDetail: Results!
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var imageDeslabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView()
   }
    
    func popUpView(){
        detailsImageView.kf.setImage(with: searchDetail.urls?.small?.asUrl)
        imageDeslabel.text = searchDetail.id
    }
}
