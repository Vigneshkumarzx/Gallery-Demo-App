//
//  DataModel.swift
//  Gallery-Demo-App
//
//  Created by vignesh kumar c on 17/05/22.
//

import Foundation
struct PhotosModel: Codable {
    let id: String?
    
    let width, height: Int?
    let color, blurHash: String?
    let urls: Urls?
    let links: WelcomeLinks?
    let likes: Int?
    let likedByUser: Bool?
    let sponsorship: Sponsorship?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        
        case width, height, color
        case blurHash = "blur_hash"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case sponsorship, user
    }
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Sponsorship
struct Sponsorship: Codable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineURL: String?
    let sponsor: User?

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline
        case taglineURL = "tagline_url"
        case sponsor
    }
}

// MARK: - User
struct User: Codable {
    let id: String?
    
    let username, name, firstName: String?
    let portfolioURL: String?
    let bio: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos, forHire: Bool?
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case id
       
        case username, name
        case firstName = "first_name"
        case portfolioURL = "portfolio_url"
        case bio, links
        case profileImage = "profile_image"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String?
}

// MARK: - Social
struct Social: Codable {
    let portfolioURL: String?

    enum CodingKeys: String, CodingKey {
        case portfolioURL = "portfolio_url"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb, smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

typealias photoModelArray = [PhotosModel]
