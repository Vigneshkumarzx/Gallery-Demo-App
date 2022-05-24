//
//  ImageService.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation

class ImageService {
   static let shared = ImageService()
    
     func getImageMore(pages: String, completion: @escaping (Result<[Results], Error>) -> Void) {
         let url = URLGenerator.GET_PHOTOS + "?page=\(pages)"
        NetworkManager.get(url) { (response, _) in
            do {
                if let data = response {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([Results].self, from: data)
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
         // let quary = quary.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
         let params: [String: Any] = ["query": quary]
         let baseUrl = URLGenerator.SEARCH_PHOTOS
         var urlComponent = URLComponents(string: baseUrl)
         urlComponent?.queryItems = params.map {URLQueryItem(name: $0, value: "\($1)")}
         NetworkManager.get(urlComponent?.url?.absoluteString ?? baseUrl) { (response, _) in
            do {
                if let data = response {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(SearchImage.self, from: data)
                    completion(Result.success(model))
                } else {
                    print("Fetching error")
                }
            } catch {
                print("catch error")
                completion(Result.failure(error))
            }
        } failed: { (error, _) in
           if let error = error {
                completion(Result.failure(error))
            }
        }
    }
}
