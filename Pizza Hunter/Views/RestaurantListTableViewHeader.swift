//
//  RestaurantListTableViewHeader.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit

@objc protocol RestaurantListTableViewHeaderDelegate {
    func didTapHeaderButton(_ headerView: RestaurantListTableViewHeader)
}

class RestaurantListTableViewHeader: BaseView {
    
    lazy var locationButton: BaseButton = {
        let btn = BaseButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 1
        btn.backgroundColor = .white
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17.0)
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, viewPadding, 0, 0)
        btn.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    weak var delegate: RestaurantListTableViewHeaderDelegate?
    
    var location: String? {
        didSet {
            locationButton.setTitle(location, for: .normal)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(locationButton)
        locationButton.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: viewPadding, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

@objc extension RestaurantListTableViewHeader {
    func changeButtonTapped() {
        delegate?.didTapHeaderButton(self)
    }
}


