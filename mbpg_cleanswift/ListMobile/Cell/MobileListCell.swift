//
//  MobileListCell.swift
//  mbpgapp
//
//  Created by Rattee Wariyawutthiwat on 6/7/2561 BE.
//  Copyright © 2561 Rattee Wariyawutthiwat. All rights reserved.
//

import UIKit
import Kingfisher

protocol MobileListCellProtocol {
  func favouriteDidTapped(id:Int)
}

class MobileListCell: UITableViewCell {
  
  static let nibName: String = String(describing: MobileListCell.self)
  static let reuseIdentifier: String = String(describing: MobileListCell.self)
  
  @IBOutlet fileprivate weak var nameLabel: UILabel!
  @IBOutlet fileprivate weak var descriptionLabel: UILabel!
  @IBOutlet fileprivate weak var priceLabel: UILabel!
  @IBOutlet fileprivate weak var ratingLabel: UILabel!
  @IBOutlet fileprivate weak var favouriteButton: UIButton!
  @IBOutlet fileprivate weak var thumbImageView: UIImageView!
  
  private var delegate: MobileListCellProtocol?
  private var displayedMobile: ListMobile.FetchMobile.ViewModel.DisplayedMobile?
  
  @IBAction func favouritePressed() {
    guard let dm = displayedMobile else { return }
    delegate?.favouriteDidTapped(id: dm.id)
    
  }
  
  func set(filterOption: ListMobile.FetchMobile.Request.FilterOption,
           delegate: MobileListCellProtocol,
           displayedMobile: ListMobile.FetchMobile.ViewModel.DisplayedMobile) {
    self.delegate = delegate
    self.displayedMobile = displayedMobile
    
    nameLabel.text = displayedMobile.name
    descriptionLabel.text = displayedMobile.description
    priceLabel.text = displayedMobile.price
    ratingLabel.text = displayedMobile.rating
    thumbImageView.kf.setImage(with: displayedMobile.thumbUrl, placeholder: #imageLiteral(resourceName: "ph_default"))
    
    let favStateImage =  displayedMobile.isFavourite ? #imageLiteral(resourceName: " ic_fav") : #imageLiteral(resourceName: "ic_unfav")
    favouriteButton.setImage(favStateImage, for: .normal)
    
    switch filterOption {
    case .all:
      favouriteButton.isHidden = false
    default:
      favouriteButton.isHidden = true
    }
    
  }
}
