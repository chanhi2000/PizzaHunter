//
//  YelpAPI.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import Foundation
import Siesta

class YelpAPI {
    static let sharedInstance = YelpAPI()
    
//    private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .image, .json])
    private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .image])
    
    private init() {
        LogCategory.enabled = [.network, .pipeline, .observers]
        
        service.configure("**") { (req) in
            req.headers["Authorization"]="Bearer B6sOjKGis75zALWPa7d2dNiNzIefNbLGGoF75oANINOL80AUhB1DjzmaNzbpzF-b55X-nG2RUgSylwcr_UYZdAQNvimDsFqkkhmvzk6P8Qj0yXOQXmMWgTD_G7ksWnYx"
            req.expirationTime = 60*60  // 1hr
        }
        
        let jsonDecoder = JSONDecoder()
        
        service.configureTransformer("/businesses/*") { (resp) in
            try jsonDecoder.decode(RestaurantDetails.self, from: resp.content)
        }
        
        
        service.configureTransformer("/businesses/search") { (resp) in
            try jsonDecoder.decode(SearchResult<Restaurant>.self, from: resp.content).businesses
        }
        
    }
    
    func restaurantList(for location: String) -> Resource {
        return service.resource("/businesses/search")
            .withParam("term", "pizza")
            .withParam("location", location)
    }
    
    func restaurantDetails(_ id: String) -> Resource {
        return service
            .resource("/businesses")
            .child(id)
    }
}
