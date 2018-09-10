//
//  MobileDetailWorker.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol MobileDetailStoreProtocol {
  func fetchMobileImages(request: MobileDetail.FetchImages.Request,
                         completion: @escaping (Result<[MobileImageResponse]>) -> Void)
}

class MobileDetailWorker {

  var store: MobileDetailStoreProtocol

  init(store: MobileDetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  
  func fetchMobileImages(request: MobileDetail.FetchImages.Request,
                         completion: @escaping (Result<[MobileImageResponse]>) -> Void) {
    store.fetchMobileImages(request: request) { result in
      completion(result)
    }
  }
  
}
