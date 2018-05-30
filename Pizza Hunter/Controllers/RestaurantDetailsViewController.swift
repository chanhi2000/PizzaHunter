//
//  RestaurantDetailsViewController.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit
import Cosmos
import Siesta

class RestaurantDetailsViewController: UIViewController {
    
    let nameLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.text = "Restaurant Name"
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let ratingView: BaseCosmosView = {
        let cv = BaseCosmosView(frame: .zero)
        cv.settings.totalStars = 5
        cv.settings.starSize = 20
        cv.settings.updateOnTouch = true
        return cv
    }()
    
    let reviewLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let priceLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.text = "Price"
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let phoneLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.text = "1234567890"
        lbl.textColor = UIColor.rgb(red: 104, green: 187, blue: 221)
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let addressLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.text = "Addrress"
        lbl.font = .systemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let imageStackView: BaseStackView = {
        let sv = BaseStackView(frame: .zero)
        sv.distribution = .fillEqually
        sv.spacing = 0
        sv.alignment = .fill
        return sv
    }()
    
    let imageView1: BaseRemoteImageView = {
        let iv = BaseRemoteImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let imageView2: BaseRemoteImageView = {
        let iv = BaseRemoteImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let imageView3: BaseRemoteImageView = {
        let iv = BaseRemoteImageView(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var statusOverlay: ResourceStatusOverlay = {
        let sts = ResourceStatusOverlay()
        sts.embed(in: self)
        return sts
    }()
    
    var restaurantId: String!
    
    private var restaurantDetail: RestaurantDetails? {
        didSet {
            if let restaurant = restaurantDetail {
                nameLabel.text = restaurant.name
                ratingView.settings.fillMode = .precise
                ratingView.rating = Double(restaurant.rating)
                reviewLabel.text = String(describing: restaurant.reviewCount) + " reviews"
                priceLabel.text = restaurant.price
                phoneLabel.text = restaurant.displayPhone
                addressLabel.text = restaurant.location.displayAddress.joined(separator: "\n")
                if restaurant.photos.count > 0 {
                    imageView1.imageURL = restaurant.photos[0]
                }
                if restaurant.photos.count > 1 {
                    imageView2.imageURL = restaurant.photos[1]
                }
                if restaurant.photos.count > 2 {
                    imageView3.imageURL = restaurant.photos[2]
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        YelpAPI.sharedInstance.restaurantDetails(restaurantId)
            .addObserver(self)
            .addObserver(statusOverlay, owner: self)
            .loadIfNeeded()
        
        statusOverlay.embed(in: self)
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusOverlay.positionToCoverParent()
    }
}

fileprivate extension RestaurantDetailsViewController {
    func setupViews() {
        view.addSubview(imageStackView)
        imageStackView.addArrangedSubview(imageView1)
        imageStackView.addArrangedSubview(imageView2)
        imageStackView.addArrangedSubview(imageView3)
        imageStackView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 200)
        
        view.addSubview(nameLabel)
        view.addSubview(ratingView)
        view.addSubview(reviewLabel)
        view.addSubview(priceLabel)
        view.addSubview(phoneLabel)
        view.addSubview(addressLabel)
        nameLabel.anchor(imageStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 53, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        ratingView.anchor(nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        ratingView.anchorCenterXToSuperview()
        reviewLabel.anchor(ratingView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        priceLabel.anchor(reviewLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 13.5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        phoneLabel.anchor(priceLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        addressLabel.anchor(phoneLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 100)
    }
}

// MARK: - ResourceObserver
extension RestaurantDetailsViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        restaurantDetail = resource.typedContent()
    }
}
