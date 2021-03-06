//
//  ListMobileRouter.swift
//  mbpg_cleanswift
//
//  Created by Rattee W. on 6/9/2561 BE.
//  Copyright (c) 2561 Rattee W.. All rights reserved.
//

import UIKit

protocol ListMobileRouterInput {
  func navigateToSomewhere()
  func routeToMobileDetail(segue: UIStoryboardSegue?)
}

protocol ListMobileDataPassing
{
  var dataStore: ListMobileDataStore? { get }
}

class ListMobileRouter: ListMobileRouterInput, ListMobileDataPassing {
  
  weak var viewController: ListMobileViewController!
  var dataStore: ListMobileDataStore?

  // MARK: - Navigation

  func navigateToSomewhere() {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:

    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)

    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)

    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)

    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }
  
  func navigateToMobileDetail(source: ListMobileViewController, destination: MobileDetailViewController) {
    source.navigationController?.pushViewController(destination, animated: true)
  }
  
  func routeToMobileDetail(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destVC = segue.destination as! MobileDetailViewController
      var destDS = destVC.router.dataStore
      passDataToMobileDetail(source: dataStore!, destination: &destDS!)
    } else {
      let destVC = viewController.storyboard?.instantiateViewController(withIdentifier: "MobileDetailViewController") as! MobileDetailViewController
      var destDS = destVC.router.dataStore
      passDataToMobileDetail(source: dataStore!, destination: &destDS!)
      navigateToMobileDetail(source: viewController!, destination: destVC)
    }
  }
  

  // MARK: - Communication

  func passDataToMobileDetail(source: ListMobileDataStore, destination: inout MobileDetailDataStore) {
    let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
    destination.mobile = source.mobileList[selectedRow!]
  }
  
  func passDataToNextScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router which scenes it can communicate with

    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router how to pass data to the next scene

    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
}
