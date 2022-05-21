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

class HomeScreenViewController: UIViewController {
  

    @IBOutlet weak var collectionView: UICollectionView!
    
   
    var viewModel = ImageViewModel()
    var pages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getImages()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        registerCell()
        
    }
    func registerCell(){
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(UINib(nibName: "LoaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoaderCollectionViewCell")
    }
}

extension HomeScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(signOf: 50.0 , magnitudeOf: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {if indexPath.row == viewModel.photosArray.count - 1 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoaderCollectionViewCell", for: indexPath) as! LoaderCollectionViewCell
        cell.loaderActivity.startAnimating()
        return cell
        
    } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.setup(image: viewModel.photosArray[indexPath.row])
        cell.contentView.backgroundColor = .red
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerView", for: indexPath)
       return footerView
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pages += 1
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height){
            self.viewModel.getImageMore(pages: String(pages)) { error in
                if let error = error {
                    print(error)
                }else {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func getImages(){
        SVProgressHUD.show()
        viewModel.getImage { error in
            SVProgressHUD.dismiss()
            if let error = error {
                print(error)
            }
            else {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}
