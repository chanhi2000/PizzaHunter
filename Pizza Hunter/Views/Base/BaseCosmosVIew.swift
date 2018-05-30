//
//  BaseCosmosVIew.swift
//  Pizza Hunter
//
//  Created by 전정철 on 30/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import Cosmos

class BaseCosmosView : CosmosView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseCosmosView: BaseViewDelegate {  func setupViews() {}  }
