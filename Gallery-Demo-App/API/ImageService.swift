//
//  ImageService.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation

class ImageService {
    
   static let shared = ImageService()
    
     func getImage(completion: @escaping (Result<photoModelArray, Error>) -> Void) {

        let url = "https://api.unsplash.com/photos?page=1"

        NetworkManager.get(url, token: "") { (response, _) in
            do {
                if let data = response {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(photoModelArray.self, from: data)
                    completion(Result.success(model))
                }
            } catch {
                completion(Result.failure(error))
            }
        } failed: { (error, _) in
            if let error = error {
                completion(Result.failure(error))
            }
        }
    }
    
     func getImageMore(pages: String, completion: @escaping (Result<photoModelArray, Error>) -> Void) {

        let url = "https://api.unsplash.com/photos?page=\(pages)"

        NetworkManager.get(url, token: "") { (response, _) in
            do {
                if let data = response {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(photoModelArray.self, from: data)
                    completion(Result.success(model))
                }
            } catch {
                completion(Result.failure(error))
            }
        } failed: { (error, _) in
            if let error = error {
                completion(Result.failure(error))
            }
        }
    }
    
     func searchImage(quary: String , completion: @escaping (Result<SearchImage, Error>) -> Void) {

        let url = "https://api.unsplash.com/search/photos?query=\(quary)"

        NetworkManager.get(url, token: "") { (response, _) in
            do {
                if let data = response {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(SearchImage.self, from: data)
                    completion(Result.success(model))
                }
            } catch {
                completion(Result.failure(error))
            }
        } failed: { (error, _) in
            if let error = error {
                completion(Result.failure(error))
            }
        }
    }
}
