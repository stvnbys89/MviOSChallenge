//
//  PinboardItem.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

struct PinboardItem: Codable, Identifiable{
    
    let id : String?
    let created_at : String?
    let width : Int?
    let height : Int?
    let color : String?
    let likes : Int?
    let liked_by_user : Bool?
    let user : User?
    let current_user_collections : [String]?
    let urls : Urls?
    let categories : [Categories]?
    let links : Links?
    
    enum PinboardItemKeys: String, CodingKey {
        
        case id = "id"
        case createdAt = "created_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case user = "user"
        case currentUserCollections = "current_user_collections"
        case urls = "urls"
        case categories = "categories"
        case links = "links"
        
    }
    
    public init(from decoder: Decoder) throws {
        
        let pinboardItemKeyValues = try decoder.container(keyedBy: PinboardItemKeys.self)
        id = try pinboardItemKeyValues.decodeIfPresent(String.self, forKey: .id)
        created_at = try pinboardItemKeyValues.decodeIfPresent(String.self, forKey: .createdAt)
        width = try pinboardItemKeyValues.decodeIfPresent(Int.self, forKey: .width)
        height = try pinboardItemKeyValues.decodeIfPresent(Int.self, forKey: .height)
        color = try pinboardItemKeyValues.decodeIfPresent(String.self, forKey: .color)
        likes = try pinboardItemKeyValues.decodeIfPresent(Int.self, forKey: .likes)
        liked_by_user = try pinboardItemKeyValues.decodeIfPresent(Bool.self, forKey: .likedByUser)
        user = try pinboardItemKeyValues.decodeIfPresent(User.self, forKey: .user)
        current_user_collections = try pinboardItemKeyValues.decodeIfPresent([String].self, forKey: .currentUserCollections)
        urls = try pinboardItemKeyValues.decodeIfPresent(Urls.self, forKey: .urls)
        categories = try pinboardItemKeyValues.decodeIfPresent([Categories].self, forKey: .categories)
        links = try pinboardItemKeyValues.decodeIfPresent(Links.self, forKey: .links)
    }
    
}

