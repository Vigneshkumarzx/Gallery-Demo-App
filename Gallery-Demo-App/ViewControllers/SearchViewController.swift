//
//  SearchViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import SVProgressHUD


class SearchViewController: UIViewController {
    
    
    var imageDetails: [Results] = []
    var viewModel = SearchViewModel()
    var SearchedViewControllers: [UIViewController] = []

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchImageTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchImageTableViewCell")
        searchImages()
        searchBar.delegate = self
        
    }
    

}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImageTableViewCell", for: indexPath) as! SearchImageTableViewCell
        cell.setup(search: imageDetails[indexPath.item])
        return cell
    }
    
   
    
    func searchImages(quary: String = "water"){
        SVProgressHUD.show()
        self.viewModel.searchImage(quary: quary){ result in
            switch result {
            case .success(let value):
                SVProgressHUD.dismiss()
                self.imageDetails.removeAll()
                self.imageDetails = value
                print(value)
                print(self.imageDetails)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(callApi), object: nil)
        self.perform(#selector(callApi), with: nil, afterDelay: 0.5)
        return true
    }
  
    @objc func callApi() {
        guard let searchText = searchBar.text else { return }
//        guard let searcVc = SearchedViewControllers[0] as? SearchViewController else { return }
        searchImages(quary: searchText)
    }
    
    
    
}
