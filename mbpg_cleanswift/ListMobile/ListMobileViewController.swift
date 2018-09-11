//
//  ListMobileViewController.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobileViewControllerInterface: class {
  func displayMobileList(viewModel: ListMobile.FetchMobile.ViewModel)
  func displayUpdateFavourite(viewModel: ListMobile.Favourite.ViewModel)
}

class ListMobileViewController: UIViewController, ListMobileViewControllerInterface {
  var interactor: ListMobileInteractorInterface!
  var router: ListMobileRouter!
  
  fileprivate var displayMobiles: [ListMobile.FetchMobile.ViewModel.DisplayedMobile] = []
  fileprivate var currentFilter: ListMobile.FetchMobile.Request.FilterOption = .all
  fileprivate var currentOrder: ListMobile.FetchMobile.Request.OrderOption = .none
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var segmentedControl: CustomSegmentedControl!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: ListMobileViewController) {
    let router = ListMobileRouter()
    router.viewController = viewController
    
    let presenter = ListMobilePresenter()
    presenter.viewController = viewController
    
    let interactor = ListMobileInteractor()
    interactor.presenter = presenter
    interactor.worker = ListMobileWorker(store: ListMobileAPI())
    
    viewController.interactor = interactor
    viewController.router = router
    
    router.dataStore = interactor
  }
  
  private func setUpTableView() {
    tableView.register(UINib(nibName: MobileListCell.nibName, bundle: nil),
                       forCellReuseIdentifier: MobileListCell.reuseIdentifier)
    
    tableView.delegate = self
    tableView.dataSource = self
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControl.items = ["All", "Favourite"]
    setUpTableView()
    view.showLoadingView()
    fetchDataOnLoad()
  }
  
  // MARK: - Event handling
  
  func fetchDataOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = ListMobile.FetchMobile.Request(filter: currentFilter, order: currentOrder)
    interactor.fetchMobileList(request: request)
  }
  
  // MARK: - Display logic
  
  func displayMobileList(viewModel: ListMobile.FetchMobile.ViewModel) {
    view.hideLoadingView()
    view.hideEmptyView()
    self.displayMobiles = viewModel.displayMobiles
    if self.displayMobiles.isEmpty {
      view.showEmptyView()
    }
    self.tableView.reloadSections([0], with: .automatic)
  }
  
  func displayUpdateFavourite(viewModel: ListMobile.Favourite.ViewModel) {
    fetchDataOnLoad()
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func showSortingSelection() {
    let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
    let options: [ListMobile.FetchMobile.Request.OrderOption] = [.priceLowToHigh, .priceHighToLow, .rating]
    options.forEach { [weak self] option in
      alert.addAction(UIAlertAction(title: option.title, style: .default, handler: { [weak self] _ in
        guard let strongSelf = self else { return }
        strongSelf.currentOrder = option
        let request = ListMobile.FetchMobile.Request(filter: strongSelf.currentFilter, order: option)
        strongSelf.interactor.fetchMobileList(request: request)
      }))
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func segmentChanged() {
    switch segmentedControl.selectedIndex {
    case 1:
      currentFilter = .favourite
    default:
      currentFilter = .all
    }    
    fetchDataOnLoad()
  }
}

extension ListMobileViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayMobiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MobileListCell.reuseIdentifier, for: indexPath)
    if let cell = cell as? MobileListCell {
      let dm = displayMobiles[indexPath.row]
      cell.set(filterOption: currentFilter,
               delegate: self,
               displayedMobile: dm)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    router.routeToMobileDetail(segue: nil)
  }
}

extension ListMobileViewController: MobileListCellProtocol {
  func favouriteDidTapped(id: Int) {
    interactor.favouriteToggle(request: ListMobile.Favourite.Request(id: id))
  }
}
