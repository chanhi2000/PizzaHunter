//
//  RestaurantDetail.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit

struct RestaurantDetails: Codable {
    let name: String
    let imageUrl: String
    let rating: CGFloat
    let reviewCount: Int
    let price: String
    let displayPhone: String
    let photos: [String]
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case rating
        case reviewCount = "review_count"
        case price
        case displayPhone = "display_phone"
        case photos
        case location
    }
}

struct Location: Codable {
    let displayAddress: [String]
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}


