//
//  ListMobileViewController.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobileViewControllerInterface: class {
  func displayMobileList(viewModels: ListMobile.FetchMobile.ViewModel)
}

class ListMobileViewController: UIViewController, ListMobileViewControllerInterface {
  var interactor: ListMobileInteractorInterface!
  var router: ListMobileRouter!
  
  var displayMobiles: [ListMobile.FetchMobile.ViewModel.DisplayedMobile] = []
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet fileprivate var segmentedControl: CustomSegmentedControl!
  
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
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControl.items = ["All", "Favourite"]
    setUpTableView()
    fetchDataOnLoad()
  }
  
  // MARK: - Event handling
  
  func fetchDataOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = ListMobile.FetchMobile.Request(order: .none)
    interactor.fetchMobileList(request: request)
  }
  
  // MARK: - Display logic
  
  func displayMobileList(viewModels: ListMobile.FetchMobile.ViewModel) {
    self.displayMobiles = viewModels.displayMobiles
    self.tableView.reloadData()
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToListMobileViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func showSortingSelection() {
    let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
    let options: [ListMobile.FetchMobile.Request.OrderOption] = [.priceLowToHigh, .priceHighToLow, .rating]
    options.forEach { [weak self] option in
      alert.addAction(UIAlertAction(title: option.title, style: .default, handler: { [weak self] _ in
        guard let strongSelf = self else { return }
        let request = ListMobile.FetchMobile.Request(order: option)
        strongSelf.interactor.fetchMobileList(request: request)
      }))
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
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
      cell.set(displayedMobile: dm)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    router.routeToMobileDetail(segue: nil)
  }
}
