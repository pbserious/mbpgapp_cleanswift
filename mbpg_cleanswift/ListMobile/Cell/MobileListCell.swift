//
//  MobileListCell.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit
import Kingfisher

class MobileListCell: UITableViewCell {
  
  static let nibName: String = String(describing: MobileListCell.self)
  static let reuseIdentifier: String = String(describing: MobileListCell.self)
  
  @IBOutlet fileprivate weak var nameLabel: UILabel!
  @IBOutlet fileprivate weak var descriptionLabel: UILabel!
  @IBOutlet fileprivate weak var priceLabel: UILabel!
  @IBOutlet fileprivate weak var ratingLabel: UILabel!
  @IBOutlet fileprivate weak var favouriteButton: UIButton!
  @IBOutlet fileprivate weak var thumbImageView: UIImageView!
  
  @IBAction func favouritePressed() {
    //vm.toggleFavourite()
    updateFavouriteButton()
  }
  
  func set(displayedMobile: ListMobile.FetchMobile.ViewModel.DisplayedMobile) {
    nameLabel.text = displayedMobile.name
    descriptionLabel.text = displayedMobile.description
    priceLabel.text = displayedMobile.price
    ratingLabel.text = displayedMobile.rating
    thumbImageView.kf.setImage(with: displayedMobile.thumbUrl, placeholder: #imageLiteral(resourceName: "ph_default"))
  }
  
  
  func updateFavouriteButton() {
//    let favStateImage =  vm.isFavourite ? #imageLiteral(resourceName: " ic_fav") : #imageLiteral(resourceName: "ic_unfav")
//    favouriteButton.setImage(favStateImage, for: .normal)
//    favouriteButton.isHidden = !vm.isToggleFavouriteEnable
  }
}
