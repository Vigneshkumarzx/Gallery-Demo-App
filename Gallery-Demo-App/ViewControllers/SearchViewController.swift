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
        searchImageTableView.delegate = self
        searchImageTableView.dataSource = self
        searchImageTableView.register(UINib(nibName: "SearchImageTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchImageTableViewCell")
        searchImages()
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        searchBar.tintColor = UIColor.lightGray
        searchBar.setIcon(UIImage(named: "magnifyingglass")!)
       
    }
    
}

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
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
      let vc = storyboard.instantiateViewController(withIdentifier: "SearchDetailViewController") as! SearchDetailViewController
        vc.searchDetail = viewModel.searchArray[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
   
    func searchImages(quary: String = "cars"){
        SVProgressHUD.show()
        self.viewModel.searchImage(quary: quary){ error in
            SVProgressHUD.dismiss()
            if let error = error {
                print(error)
            } else {
                self.searchImageTableView.reloadData()
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
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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



