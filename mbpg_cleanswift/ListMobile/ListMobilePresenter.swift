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
  func presentUpdateFavourite(response: ListMobile.Favourite.Response)
}

class ListMobilePresenter: ListMobilePresenterInterface {
  
  weak var viewController: ListMobileViewControllerInterface!

  // MARK: - Presentation logic
  
  func presentListMobile(response: ListMobile.FetchMobile.Response) {
    let displayedMobiles = response.mobiles.map { data -> ListMobile.FetchMobile.ViewModel.DisplayedMobile in
      return ListMobile.FetchMobile.ViewModel.DisplayedMobile(id: data.id,
                                                              name: data.name,
                                                              brand: data.brand,
                                                              price: String(format: "$%.2f", data.price),
                                                              rating: "\(data.rating)",
                                                              description: data.description,
                                                              thumbUrl: data.thumbnailUrl,
                                                              isFavourite: data.isFavourite)
    }
    let vm = ListMobile.FetchMobile.ViewModel(displayMobiles: displayedMobiles)
    viewController.displayMobileList(viewModel: vm)
  }
  
  func presentUpdateFavourite(response: ListMobile.Favourite.Response) {
    viewController.displayUpdateFavourite(viewModel: ListMobile.Favourite.ViewModel())
  }
  
}
