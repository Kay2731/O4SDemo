//
//  Links.swift
//  O4S
//
//  Created by Keertika on 06/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation
struct Links:Codable {
    var urlString:String?
    var html:String
    var download:String
    
    enum CodingKeys:String,CodingKey{
        case urlString = "self"
        case html
        case download
    }
}

struct User:Codable
{
    var firstName: String
    var lastName: String
    var country: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case country
    }
}
