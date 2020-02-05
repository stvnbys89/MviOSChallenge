//
//  Categories.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

struct Categories: Codable{

    let id : Int?
    let title : String?
    let photo_count : Int?
    let links : Links?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case photo_count = "photo_count"
        case links = "links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        photo_count = try values.decodeIfPresent(Int.self, forKey: .photo_count)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
    }
    
}
