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
        ImageService.shared.getImage {[weak self] (result) in
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
    
    func getImageMore(pages: String, completion: @escaping (Error?) -> Void) {
        ImageService.shared.getImageMore(pages: pages ) { [weak self] (result) in
            switch result {
            case .success(let model) :
                guard let self = self else {return}
                self.photosArray.append(contentsOf: model)
                completion(nil)
            case.failure(let error) :
                completion(error)
            }
        }
    }
}
