//
//  BaseRemoteImageView.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit
import Siesta

class BaseRemoteImageView: RemoteImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseRemoteImageView: BaseViewDelegate {  func setupViews() {}  }
