//
//  SearchModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 18/05/22.
//

import Foundation

// MARK: - SearchImage
struct SearchImage: Codable {
    let total, totalPages: Int?
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

///  search. likes
///  searcj.user.username
///  search.user.bio
///  search.url.small
///

// MARK: - Result
struct Results: Codable {
    let id: String?
    let urls: Urlinks?
    let likes: Int?
    let user: Users?

    enum CodingKeys: String, CodingKey {
        case id
        case  likes
        case user
        case urls
    }
}
// MARK: - User
struct Users: Codable {
    let id: String
    let username, name, firstName: String
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos, forHire: Bool
   

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
    }
}

// MARK: - Urls
struct Urlinks: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

enum TypeEnum: String, Codable {
    case landingPage = "landing_page"
    case search = "search"
}

