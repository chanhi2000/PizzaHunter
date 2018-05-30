//
//  RestaurantListTableViewCell.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit

class RestaurantListTableViewCell: BaseTableViewCell {
    let nameLabel: BaseLabel = {
        let lbl = BaseLabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.numberOfLines = 1
        lbl.text = "Restaurant Name"
        return lbl
    }()
    
    let iconIV: BaseRemoteImageView = {
        let iv = BaseRemoteImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconIV)
        iconIV.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: viewPadding, leftConstant: viewPadding, bottomConstant: viewPadding, rightConstant: viewPadding, widthConstant: iconIVDimen, heightConstant: iconIVDimen)
        addSubview(nameLabel)
        nameLabel.anchor(topAnchor, left: iconIV.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: viewPadding, leftConstant: viewPadding, bottomConstant: viewPadding, rightConstant: viewPadding, widthConstant: 0, heightConstant: 0)
    }
    
}
