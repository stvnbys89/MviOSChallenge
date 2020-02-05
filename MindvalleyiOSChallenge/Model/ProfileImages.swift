//
//  ProfileImages.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

struct ProfileImages:Codable {
    
    let small : String?
    let medium : String?
    let large : String?
    
    enum ProfileImagesKeys: String, CodingKey {

        case small = "small"
        case medium = "medium"
        case large = "large"
    }

    init(from decoder: Decoder) throws {
        let profileImageKeyValue = try decoder.container(keyedBy: ProfileImagesKeys.self)
        small = try profileImageKeyValue.decodeIfPresent(String.self, forKey: .small)
        medium = try profileImageKeyValue.decodeIfPresent(String.self, forKey: .medium)
        large = try profileImageKeyValue.decodeIfPresent(String.self, forKey: .large)
    }
}
