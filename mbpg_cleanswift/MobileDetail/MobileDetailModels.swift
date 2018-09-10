//
//  MobileDetailModels.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

struct MobileDetail {
  /// This structure represents a use case
  struct GetMobile {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      var mobile: MobileData
    }
    /// Data struct sent to ViewController
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
      }
      var displayMobile: DisplayedMobile
    }
  }
  
  struct FetchImages {
    struct Request {
      var mobileId:Int
    }
    struct Response {
      var images: [MobileImageResponse]
    }
    struct ViewModel {
      var urls:[URL]
    }
  }
}
