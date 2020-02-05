//
//  Urls.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

struct Urls:Codable {

    let raw : String?
    let full : String?
    let regular : String?
    let small : String?
    let thumb : String?
    
   enum UrlKeys: String, CodingKey {

        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }

    init(from decoder: Decoder) throws {
        let urlKeyValue = try decoder.container(keyedBy: UrlKeys.self)
        raw = try urlKeyValue.decodeIfPresent(String.self, forKey: .raw)
        full = try urlKeyValue.decodeIfPresent(String.self, forKey: .full)
        regular = try urlKeyValue.decodeIfPresent(String.self, forKey: .regular)
        small = try urlKeyValue.decodeIfPresent(String.self, forKey: .small)
        thumb = try urlKeyValue.decodeIfPresent(String.self, forKey: .thumb)
    }
    
}
