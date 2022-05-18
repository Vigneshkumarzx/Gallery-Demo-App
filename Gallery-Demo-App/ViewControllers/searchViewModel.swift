//
//  searchViewModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import Foundation

class SearchViewModel{
    
    var searchArray: [Results] = []
    
    func searchImage(quary: String, completion: @escaping (Result<[Results], Error>) -> Void) {
        
        ImageService.searchImage(quary: quary){ [weak self] (result) in
            switch result {
            case .success(let model) :
                guard let self = self else {return}
                self.searchArray.removeAll()
                self.searchArray = model.results
                completion(.success(self.searchArray))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
