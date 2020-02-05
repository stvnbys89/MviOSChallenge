//
//  Links.swift
//  MindvalleyiOSChallenge
//
//  Created by Steven on 28/01/2020.
//  Copyright © 2020 StvnBys. All rights reserved.
//

import UIKit

struct Links:Codable {
    let profile : String?
    let html : String?
    let download : String?
    
    enum LinkKeys: String, CodingKey {

        case profile = "self"
        case html = "html"
        case download = "download"
    }

    init(from decoder: Decoder) throws {
        let linkKeyValue = try decoder.container(keyedBy: LinkKeys.self)
        profile = try linkKeyValue.decodeIfPresent(String.self, forKey: .profile)
        html = try linkKeyValue.decodeIfPresent(String.self, forKey: .html)
        download = try linkKeyValue.decodeIfPresent(String.self, forKey: .download)
    }
}
