//
//  FavouriteWorker.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 10/9/2561 BE.
//  Copyright © 2561 Rattee W. All rights reserved.
//

import Foundation

fileprivate let FAV_ARRAY_KEY = "FAV_ARRAY_KEY"

protocol FavouriteWorkerProtocol {
  var favouriteArray: [Int] { get }
  func updateFavouriteArray(_ arr:[Int])
  func favouriteMobile(for id:Int)
  func unfavouriteMobile(for id:Int)
  func isFavourite(for id:Int) -> Bool
  func toggleFavourite(for id:Int)
}

extension FavouriteWorkerProtocol {
  // MARK: - Interface
  // Favourite new mobile id
  func favouriteMobile(for id:Int) {
    var arr = favouriteArray
    if !arr.contains(id) {
      arr.append(id)
      updateFavouriteArray(arr)
    }
  }
  
  // Unfavourite new mobile id
  func unfavouriteMobile(for id:Int) {
    var arr = favouriteArray
    
    var removedIndex: Int?
    for index in 0...arr.count-1 {
      if id == arr[index] {
        removedIndex = index
      }
    }
    if let index = removedIndex {
      arr.remove(at: index)
      updateFavouriteArray(arr)
    }
  }
  
  // check wheter specific id is favourite
  func isFavourite(for id: Int) -> Bool {
    return favouriteArray.contains(id)
  }
}

class FavouriteWorker: FavouriteWorkerProtocol {
  
  var favouriteArray: [Int] {
    return UserDefaults.standard.array(forKey: FAV_ARRAY_KEY) as? [Int] ?? []
  }
  
  func updateFavouriteArray(_ arr:[Int]) {
    UserDefaults.standard.set(arr, forKey: FAV_ARRAY_KEY)
  }
  
  func toggleFavourite(for id: Int) {
    if isFavourite(for: id) {
      unfavouriteMobile(for: id)
    } else {
      favouriteMobile(for: id)
    }
  }
  
}
