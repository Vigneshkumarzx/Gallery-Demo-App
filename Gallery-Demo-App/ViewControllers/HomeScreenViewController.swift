//
//  ViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import Foundation
import SVProgressHUD
import CoreData
import Apploader

protocol AlertDelegate: AnyObject {
    func showAlert(imageSaved: Bool)
}
class HomeScreenViewController: UIViewController  {
 
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var viewModel = ImageViewModel()
    var pages = 1
    let layout = UICollectionViewFlowLayout()
    var alertHud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImages()
        registerCell()
        configLoader()
        configureCollectionLayout()
    }
    
    func registerCell() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        imageCollectionView.register(UINib(nibName: "LoaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoaderCollectionViewCell")
    }
    func configLoader() {
        self.alertHud = MBProgressHUD(view: self.view)
        alertHud.bezelView.color = UIColor(red: 53, green: 63, blue: 77, alpha: 1)
        alertHud.bezelView.backgroundColor = .black
        alertHud.contentColor = .white
        alertHud.label.textColor = .white
        self.view.addSubview(self.alertHud)
    }
    func configureCollectionLayout() {
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
}

extension HomeScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == viewModel.photosArray.count - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
            cell.loaderActivity.startAnimating()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            cell.setup(image: viewModel.photosArray[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        vc.details = viewModel.photosArray[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height: widthPerItem)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pages += 1
        let position = scrollView.contentOffset.y
        if position > (imageCollectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.viewModel.getImageMore(pages: String(pages)) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.imageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    func getImages() {
        SVProgressHUD.show()
        viewModel.getImageMore(pages: "1") { error in
            if  error == nil {
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.imageCollectionView.reloadData()
                }
            } else {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
            
        }
    }
}
extension HomeScreenViewController: AlertDelegate {
    func showAlert(imageSaved: Bool) {
        imageSaved ? self.alertHud.showText(msg: "Image saved to offline",delay: 2) : (self.alertHud.showText(msg: "Image already Saved",delay: 2))
    }
}
