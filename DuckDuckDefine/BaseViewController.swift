//
//  BaseViewController.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 12/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import UIKit
import RxSwift

/**
 Common base class for view controller's to extend from, providing common functionality
 */
class BaseViewController : UIViewController {
    let disposeBag = DisposeBag() // For attaching observables
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
