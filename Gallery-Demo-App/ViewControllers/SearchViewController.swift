//
//  SearchViewController.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import UIKit
import SVProgressHUD


class SearchViewController: UIViewController {
  

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchImageTableView: UITableView!
    
    var viewModel = SearchViewModel()
    var SearchedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchImages()
        hideKeyboardWhenTappedAround()
        registerCell()
        searchBarConfigure()
    }
    func registerCell() {
        searchBar.delegate = self
        searchImageTableView.delegate = self
        searchImageTableView.dataSource = self
        searchImageTableView.separatorStyle = .none
        searchImageTableView.tableFooterView = nil
        let searchImageTableViewCellNib = UINib(nibName: "SearchImageTableViewCell", bundle: nil)
        searchImageTableView.register(searchImageTableViewCellNib, forCellReuseIdentifier: "SearchImageTableViewCell")
    }
    func searchBarConfigure() {
        searchBar.tintColor = UIColor.lightGray
        if let searBarIcon = UIImage(named: "magnifyingglass") {
            searchBar.setIcon(searBarIcon)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImageTableViewCell", for: indexPath) as! SearchImageTableViewCell
        cell.setup(search: viewModel.searchArray[indexPath.item])
        cell.contentView.sizeToFit()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        vc.details = viewModel.searchArray[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchImages(quary: String = "cars"){
        SVProgressHUD.show()
        self.viewModel.searchImage(quary: quary){ error in
            
            DispatchQueue.main.async {
                if  error == nil {
                    SVProgressHUD.dismiss()
                    self.searchImageTableView.reloadData()
                } else {
                    SVProgressHUD.dismiss()
                    print("error")
                    SVProgressHUD.showError(withStatus: "No data")
                    self.viewModel.searchArray.removeAll()
                    self.searchImageTableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(callApi), object: nil)
        self.perform(#selector(callApi), with: nil)
        return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func callApi() {
        guard let searchText = searchBar.text else { return }
        searchImages(quary: searchText)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



