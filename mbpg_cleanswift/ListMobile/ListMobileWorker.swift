//
//  ListMobileWorker.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobileStoreProtocol {
  func fetchMobiles(_ orderOption: ListMobile.FetchMobile.Request.OrderOption, _ completion: @escaping (Result<[MobileData]>) -> Void)
}

class ListMobileWorker {

  var store: ListMobileStoreProtocol

  init(store: ListMobileStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  
  func fetchMobiles(_ orderOption: ListMobile.FetchMobile.Request.OrderOption, completion: @escaping (Result<[MobileData]>) -> Void) {
    store.fetchMobiles(orderOption) { result in
      completion(result)
    }
  }
}
