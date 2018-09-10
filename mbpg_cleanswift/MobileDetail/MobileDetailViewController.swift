//
//  MobileDetailViewController.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 7/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol MobileDetailViewControllerInterface: class {
  func displayMobileData(viewModel: MobileDetail.GetMobile.ViewModel)
  func displayMobileImages(viewModel: MobileDetail.FetchImages.ViewModel)
}

class MobileDetailViewController: UIViewController, MobileDetailViewControllerInterface {
  var interactor: MobileDetailInteractorInterface!
  var router: MobileDetailRouter!

  @IBOutlet fileprivate weak var scrollableImagesView: HorizontalScrollableImagesView!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MobileDetailViewController) {
    let router = MobileDetailRouter()
    router.viewController = viewController

    let presenter = MobileDetailPresenter()
    presenter.viewController = viewController

    let interactor = MobileDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileDetailWorker(store: MobileDetailStore())

    viewController.interactor = interactor
    viewController.router = router
    
    router.dataStore = interactor
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    scrollableImagesView.showLoadingView()
    let request = MobileDetail.GetMobile.Request()
    interactor.getMobile(request: request)
  }

  // MARK: - Display logic

  func displayMobileData(viewModel: MobileDetail.GetMobile.ViewModel) {
    self.title = viewModel.displayMobile.name
    self.descriptionTextView.text = viewModel.displayMobile.description
    self.priceLabel.text = viewModel.displayMobile.price
    self.ratingLabel.text = viewModel.displayMobile.rating
  }
  
  func displayMobileImages(viewModel: MobileDetail.FetchImages.ViewModel) {
    scrollableImagesView.hideLoadingView()
    self.scrollableImagesView.imageUrlList = viewModel.urls
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMobileDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
