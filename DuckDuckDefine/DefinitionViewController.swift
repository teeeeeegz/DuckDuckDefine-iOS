//
//  DefinitionViewController.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 12/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

/**
 ViewController which displays information relating to a returned Definition
 */
class DefinitionViewController: UIViewController {
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var definition: SearchDefinition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    /**
     Initialise ViewController properties/functionality
     */
    private func initVC() {
        if let heading = definition?.heading {
            title = heading
        }
        
        if let description = definition?.abstractText {
            descriptionLabel.text = description
        }
        
        if let imageUrl = definition?.imageUrl {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl)
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
