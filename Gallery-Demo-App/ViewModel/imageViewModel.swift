//
//  imageViewModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation

class ImageViewModel {
    
    var photosArray: photoModelArray = []
    
    
    func getImage(completion: @escaping (Error?) -> Void) {
        
        ImageService.getImage {[weak self] (result) in
            switch result {
            case .success(let model) :
                guard let self = self else {return}
                self.photosArray = model
                completion(nil)
            case.failure(let error) :
                completion(error)
            }
            
        }
        
    }
    
    func getImageMore(pages: String, completion: @escaping (Result<photoModelArray, Error>) -> Void) {
        
        ImageService.getImageMore(pages: pages ) { [weak self] (result) in
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
