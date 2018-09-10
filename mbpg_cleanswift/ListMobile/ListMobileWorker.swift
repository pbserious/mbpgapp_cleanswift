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
  
  func fetchMobiles(_ request: ListMobile.FetchMobile.Request, completion: @escaping (Result<[MobileData]>) -> Void) {
    let orderOption = request.order
    store.fetchMobiles(orderOption) { result in
      switch result {
      // Stub the worker
      case .success(let list):
        let updatedList = list.compactMap({ data -> MobileData? in
          let favWorker = FavouriteWorker()
          var newData = data
          newData.isFavourite = favWorker.isFavourite(for: data.id)
          
          switch request.filter {
          case .favourite:
            if request.filter == .favourite && !newData.isFavourite {
              return nil
            }
          default:
            break
          }
          return newData
        })
        completion(Result<[MobileData]>.success(updatedList))
      default:
        completion(result)
      }
    }
  }
}
