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
    
    var imageDetails: photoModelArray = []
    var viewModel = ImageViewModel()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getImages()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let itemSize = (UIScreen.main.bounds.width/2) - 3

         let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         layout.itemSize = CGSize(width: itemSize, height: itemSize)

         layout.minimumInteritemSpacing = 3
         layout.minimumLineSpacing = 3

         collectionView.collectionViewLayout = layout
        
    }
}

extension HomeScreenViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(signOf: 50.0 , magnitudeOf: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.setup(image: imageDetails[indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
//        let controller = ImageDetailViewController.instantiate()
        vc.details = imageDetails[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: 150, height: 150)
//          let lay = collectionViewLayout as! UICollectionViewFlowLayout
//          let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
//          return CGSize(width:widthPerItem, height: widthPerItem)
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
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height-100-scrollView.frame.size.height){
            self.viewModel.getImageMore { result in
                switch result {
                case .success(let value):
                    self.imageDetails.append(contentsOf: value)
//                    print(value)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getImages(){
//        SVProgressHUD.show()
        self.viewModel.getImage { result in
            
            switch result {
            case .success(let value):
                self.imageDetails.removeAll()
                self.imageDetails = value
//                SVProgressHUD.dismiss()
                print(self.imageDetails)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
