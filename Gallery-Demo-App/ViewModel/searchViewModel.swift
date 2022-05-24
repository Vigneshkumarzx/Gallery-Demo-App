//
//  searchViewModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import Foundation

class SearchViewModel {
    var searchArray: [Results] = []
    
    func searchImage(quary: String, completion: @escaping (Error?) -> Void) {
        ImageService.shared.searchImage(quary: quary){ [weak self] (result) in
            switch result {
            case .success(let model) :
                self?.searchArray = model.results
                completion(nil)
            case .failure(let error) :
                completion(error)
            }
        }
    }
}
