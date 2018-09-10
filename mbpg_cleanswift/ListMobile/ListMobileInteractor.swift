//
//  ListMobileInteractor.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobileInteractorInterface {
  //func doSomething(request: ListMobile.Something.Request)
  func fetchMobileList(request: ListMobile.FetchMobile.Request)
  func favouriteToggle(request: ListMobile.Favourite.Request)
  
  var mobileList: [MobileData] { get }
}

protocol ListMobileDataStore {
  var mobileList: [MobileData] { get }
}

class ListMobileInteractor: ListMobileInteractorInterface, ListMobileDataStore {
  
  var presenter: ListMobilePresenterInterface!
  var worker: ListMobileWorker?
  var mobileList = [MobileData]()

  // MARK: - Business logic
  func fetchMobileList(request: ListMobile.FetchMobile.Request) {
    worker?.fetchMobiles(request, completion: { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let list):
        self?.mobileList = list

        let response = ListMobile.FetchMobile.Response(mobiles: strongSelf.mobileList)
        self?.presenter.presentListMobile(response: response)
      case .failure(let error):
        // TODO: present error 
        break
      }
      
    })
  }
  
  func favouriteToggle(request: ListMobile.Favourite.Request) {
    let favWorker = FavouriteWorker()
    favWorker.toggleFavourite(for: request.id)
    
    let response = ListMobile.Favourite.Response()
    self.presenter.presentUpdateFavourite(response: response)
  }
}
