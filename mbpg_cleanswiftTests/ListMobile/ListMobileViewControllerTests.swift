//
//  ListMobileViewControllerTests.swift
//  mbpg_cleanswiftTests
//
//  Created by Rattee W. on 11/9/2561 BE.
//  Copyright © 2561 Rattee W. All rights reserved.
//

@testable import mbpg_cleanswift
import XCTest

class ListMobileViewControllerTests: XCTestCase {
  
  var viewController: ListMobileViewController!
  var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setUpListMobileViewController()
  }
  
  // MARK: - Test Setup
  
  func setUpListMobileViewController() {
    viewController = UIStoryboard(name: "Main",
                                  bundle: nil).instantiateViewController(withIdentifier:
                                    "ListMobileViewController") as! ListMobileViewController
  }
  
  func loadView() {
    window.addSubview(viewController.view)
    RunLoop.current.run(until: Date())
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  // MARK: - Interactor Spy Class
  
  class ListMobileInteractorSpy: ListMobileInteractorInterface {
    
    var isFetchMobileListCalled = false
    var isFavoriteToggleCalled = false
    
    var currentFetchRequest: ListMobile.FetchMobile.Request?
    
    func fetchMobileList(request: ListMobile.FetchMobile.Request) {
      currentFetchRequest = request
      isFetchMobileListCalled = true
    }
    
    func favouriteToggle(request: ListMobile.Favourite.Request) {
      isFavoriteToggleCalled = true
    }
    
    var mobileList = [MobileData]()
    
    
  }
  
  func testShouldFetchListOnLoad() {
    // Given
    loadView()
    let interactorSpy = ListMobileInteractorSpy()
    viewController.interactor = interactorSpy
    
    // When
    viewController.viewDidLoad()
    // Then
    XCTAssert(interactorSpy.isFetchMobileListCalled, " viewDodLoad should ask interactor to fetchMobileList")
  }
  
  func testToggleFavouriteThenFetchListAgain() {
    // Given
    loadView()
    
    let interactorSpy = ListMobileInteractorSpy()
    viewController.interactor = interactorSpy
    
    // When
    viewController.favouriteDidTapped(id: 0)
    viewController.displayUpdateFavourite(viewModel: ListMobile.Favourite.ViewModel())
    
    // Then
    XCTAssert(interactorSpy.isFavoriteToggleCalled, " viewDodLoad should ask interactor to favouriteToggle")
    XCTAssert(interactorSpy.isFetchMobileListCalled, " viewDodLoad should ask interactor to fetchMobileList")
  }
  
  func testChangeSegmentedFetchWithFavouriteOption() {
    // Given
    loadView()
    
    let interactorSpy = ListMobileInteractorSpy()
    viewController.interactor = interactorSpy
    
    // When
    viewController.segmentedControl.selectedIndex = 1
    
    // Then
    XCTAssert(interactorSpy.isFetchMobileListCalled, " viewDodLoad should ask interactor to fetchMobileList")
    XCTAssert(interactorSpy.currentFetchRequest!.filter == .favourite, "currentRequest should use 'favourite' filter option")
  }
  
  func testChangeSegmentedFetchWithAllOption() {
    // Given
    loadView()
    
    let interactorSpy = ListMobileInteractorSpy()
    viewController.interactor = interactorSpy
    
    // When
    viewController.segmentedControl.selectedIndex = 1
    viewController.segmentedControl.selectedIndex = 0
    
    // Then
    XCTAssert(interactorSpy.isFetchMobileListCalled, " viewDodLoad should ask interactor to fetchMobileList")
    XCTAssert(interactorSpy.currentFetchRequest!.filter == .all, "currentRequest should use 'all' filter option")
  }
}
