//
//  MobileDetailStore.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

/*

 The MobileDetailStore class implements the MobileDetailStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */



class MobileDetailStore: MobileDetailStoreProtocol {
  
  func fetchMobileImages(request: MobileDetail.FetchImages.Request,
                         completion: @escaping (Result<[MobileImageResponse]>) -> Void) {
    let provider = MoyaProvider<MobileAPI>()
    provider.request(.getImages(id: request.mobileId)) { result in
      switch result {
      case let .success(response):
        do {
          let res = try response.filterSuccessfulStatusCodes()
          if let array = try res.mapJSON() as? [[String: Any]] {
            let list = Mapper<MobileImageResponse>().mapArray(JSONArray: array)
            completion(Result.success(list))
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
  
}
