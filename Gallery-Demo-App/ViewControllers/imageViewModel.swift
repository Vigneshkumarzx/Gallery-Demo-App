//
//  imageViewModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation

class ImageViewModel {
    
    var photosArray: photoModelArray = []
    
    
    func getImage(completion: @escaping (Result<photoModelArray, Error>) -> Void) {
        
        ImageService.getImage {[weak self] (result) in
            switch result {
            case .success(let model) :
                guard let self = self else {return}
                self.photosArray.removeAll()
                self.photosArray = model
                completion(.success(self.photosArray))
            case.failure(let error) :
                completion(.failure(error))
            }
            
        }
        
    }
    
    
    func getImageMore(completion: @escaping (Result<photoModelArray, Error>) -> Void) {
        
        ImageService.getImageMore { [weak self] (result) in
            switch result {
            case .success(let model) :
                guard let self = self else {return}
                self.photosArray.removeAll()
                self.photosArray = model
                completion(.success(self.photosArray))
            case.failure(let error) :
                completion(.failure(error))
            }
            
        }
        
    }
    

    
}
