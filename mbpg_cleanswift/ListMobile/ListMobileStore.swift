//
//  ListMobileStore.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

/*

 The ListMobileStore class implements the ListMobileStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class ListMobileStore: ListMobileStoreProtocol {
  func fetchMobiles(_ orderOption: ListMobile.FetchMobile.Request.OrderOption, _ completion: @escaping (Result<[MobileData]>) -> Void) {
    
  }

}

class ListMobileAPI: ListMobileStoreProtocol {
  // Caching magic
  private var mobileList = [MobileData]()
  
  func fetchMobiles(_ orderOption: ListMobile.FetchMobile.Request.OrderOption, _ completion: @escaping (Result<[MobileData]>) -> Void) {
    
    guard mobileList.count == 0 else {
      completion(Result.success(getOrderedList(list: mobileList, option: orderOption)))
      return
    }
    let provider = MoyaProvider<MobileAPI>()
    provider.request(.getList) { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case let .success(response):
        do {
          let res = try response.filterSuccessfulStatusCodes()
          if let array = try res.mapJSON() as? [[String: Any]] {
            let list = Mapper<MobileData>().mapArray(JSONArray: array)
            strongSelf.mobileList = list
            completion(Result.success(strongSelf.getOrderedList(list: strongSelf.mobileList,
                                                     option: orderOption)))
          } else {
            completion(Result.failure(APIError.unparsableJSON))
          }
        } catch {
          completion(Result.failure(APIError.unparsableJSON))
        }
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }
  
  func getOrderedList(list: [MobileData], option: ListMobile.FetchMobile.Request.OrderOption) -> [MobileData] {
    switch option {
    case .priceHighToLow:
      return list.sorted(by: { $0.price > $1.price })
    case .priceLowToHigh:
      return list.sorted(by: { $0.price < $1.price })
    case .rating:
      return list.sorted(by: { $0.rating > $1.rating })
    default:
      return list
    }
  }
}
