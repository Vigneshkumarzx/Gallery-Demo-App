//
//  SearchImageTableViewCell.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import Kingfisher

class SearchImageTableViewCell: UITableViewCell {


    
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    

    func setup(search: Results?) {
        guard let search = search else {return}
        searchImage.kf.setImage(with: (search.urls?.small ?? "").asUrl)
        numLikesLabel.text = "\(search.likes ?? 0)"
        usernameLabel.text = search.user?.username
        userBioLabel.text = search.user?.bio
    }

}

