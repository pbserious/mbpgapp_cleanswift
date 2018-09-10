//
//  MobileDetailPresenter.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

extension URL {
  // Solved url to https, do not want to allow arbitary loads in Info.plist
  var httpsURL: URL? {
    var comp = URLComponents(url: self, resolvingAgainstBaseURL: false)
    comp?.scheme = "https"
    return comp?.url
  }
}


protocol MobileDetailPresenterInterface {
  func presentMobileData(response: MobileDetail.GetMobile.Response)
  func presentMobileImages(response: MobileDetail.FetchImages.Response)
}

class MobileDetailPresenter: MobileDetailPresenterInterface {
  weak var viewController: MobileDetailViewControllerInterface!

  // MARK: - Presentation logic
  
  func presentMobileData(response: MobileDetail.GetMobile.Response) {
    let md = response.mobile
    let vm = MobileDetail.GetMobile.ViewModel(displayMobile:
      MobileDetail.GetMobile.ViewModel.DisplayedMobile(id: md.id,
                                                       name: md.name,
                                                       brand: md.brand,
                                                       price: "Price: $\(md.price)",
                                                       rating: "Rating: \(md.rating)",
                                                       description: md.description,
                                                       thumbUrl: md.thumbnailUrl))
    viewController.displayMobileData(viewModel: vm)
  }
  
  func presentMobileImages(response: MobileDetail.FetchImages.Response) {
    let images = response.images
    let urls = images.compactMap { imageResponse -> URL? in
      return URL(string: imageResponse.imageUrlString)?.httpsURL
    }
    let vm = MobileDetail.FetchImages.ViewModel(urls: urls)
    viewController.displayMobileImages(viewModel: vm)
    
  }
}
