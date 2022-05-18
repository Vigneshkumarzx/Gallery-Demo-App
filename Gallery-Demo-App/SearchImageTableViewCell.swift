//
//  SearchImageTableViewCell.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import Kingfisher

class SearchImageTableViewCell: UITableViewCell {


    
    @IBOutlet weak var searcImageView: UIImageView!
    
    @IBOutlet weak var descripionLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    func setup(search: Results?) {
        guard let search = search else {return}
        searcImageView.kf.setImage(with: (search.urls?.small ?? "").asUrl)
//        numLikesLabel.text = "\(search.likes)"
//        descripionLabel.text = search.imageDescription
        
    }
    
}