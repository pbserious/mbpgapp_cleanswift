//
//  MobileDetailInteractor.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol MobileDetailInteractorInterface {
  func getMobile(request: MobileDetail.GetMobile.Request)
  func fetchMobielImage(request: MobileDetail.FetchImages.Request)
}

protocol MobileDetailDataStore {
  var mobile: MobileData! { get set }
}

class MobileDetailInteractor: MobileDetailInteractorInterface, MobileDetailDataStore {
  
  var presenter: MobileDetailPresenterInterface!
  var worker: MobileDetailWorker?
  
  var mobile: MobileData!

  // MARK: - Business logic

  func getMobile(request: MobileDetail.GetMobile.Request) {
    let response = MobileDetail.GetMobile.Response(mobile: mobile)
    presenter.presentMobileData(response: response)
    let fetchImagesRequest = MobileDetail.FetchImages.Request(mobileId: mobile.id)
    fetchMobielImage(request: fetchImagesRequest)
  }
  
  func fetchMobielImage(request: MobileDetail.FetchImages.Request) {
    worker?.fetchMobileImages(request: request, completion: { [weak self] result in
      switch result {
      case .success(let imageResponseList):
        let response = MobileDetail.FetchImages.Response(images: imageResponseList)
        self?.presenter.presentMobileImages(response: response)
      case .failure(let error):
        // Handle Error here
        break
      }
      
    })
  }
  
}
