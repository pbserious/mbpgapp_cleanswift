//
//  MobileData.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright © 2561 Rattee W. All rights reserved.
//

import Foundation
import ObjectMapper

enum Result<T> {
  case success(T)
  case failure(Error)
}

struct MobileData: Mappable {
    var id: Int = -1
    var name: String = ""
    var brand: String = ""
    var rating: Float = 0.0
    var price: Double = 0.0
    var description: String = ""
    var thumnailUrlString: String = ""
    var isFavourite = false
    
    var thumbnailUrl: URL? {
        return URL(string: self.thumnailUrlString)
    }
    
    var ratingFriendlyText: String {
        return "Rating: \(rating)"
    }
    
    var priceFriendlyText: String {
        return String(format: "Price: $%.2f", price)
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        brand <- map["brand"]
        rating <- map["rating"]
        price <- map["price"]
        description <- map["description"]
        thumnailUrlString <- map["thumbImageURL"]
    }

}
