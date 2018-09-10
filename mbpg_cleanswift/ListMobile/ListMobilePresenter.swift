//
//  ListMobilePresenter.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobilePresenterInterface {
  func presentListMobile(response: ListMobile.FetchMobile.Response)
}

class ListMobilePresenter: ListMobilePresenterInterface {
  
  weak var viewController: ListMobileViewControllerInterface!

  // MARK: - Presentation logic
  
  func presentListMobile(response: ListMobile.FetchMobile.Response) {
    let displayedMobiles = response.mobiles.map { data -> ListMobile.FetchMobile.ViewModel.DisplayedMobile in
      return ListMobile.FetchMobile.ViewModel.DisplayedMobile(id: data.id,
                                                              name: data.name,
                                                              brand: data.brand,
                                                              price: "\(data.price)",
                                                              rating: "\(data.rating)",
                                                              description: data.description,
                                                              thumbUrl: data.thumbnailUrl)
    }
    let vm = ListMobile.FetchMobile.ViewModel(displayMobiles: displayedMobiles)
    viewController.displayMobileList(viewModels: vm)
  }
  
  
}
