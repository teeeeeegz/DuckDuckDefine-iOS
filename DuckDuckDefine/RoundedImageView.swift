//
//  RoundedImageView.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 12/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import UIKit

/**
 An ImageView with a rounded canvas
 */
@IBDesignable
class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
    }
}
