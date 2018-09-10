//
//  ListMobileModels.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

struct ListMobile {
  struct FetchMobile {
    struct Request {
      enum OrderOption {
        case none
        case priceLowToHigh
        case priceHighToLow
        case rating
        
        var title: String {
          switch self {
          case .priceHighToLow:
            return "High to Low"
          case .priceLowToHigh:
            return "Low to High"
          case .rating:
            return "Rating"
          default:
            return ""
          }
        }
      }
      enum FilterOption {
        case all
        case favourite
      }
      var filter: FilterOption
      var order: OrderOption      
    }
    struct Response {
      var mobiles: [MobileData]
    }
    struct ViewModel {
      struct DisplayedMobile
      {
        var id: Int
        var name: String
        var brand: String
        var price: String
        var rating: String
        var description: String
        var thumbUrl: URL?
        var isFavourite: Bool
      }
      var displayMobiles: [DisplayedMobile]
    }
  }
  
  struct Favourite {
    struct Request {
      var id: Int
    }
    struct Response {
      
    }
    struct ViewModel {
    }
  }
}
