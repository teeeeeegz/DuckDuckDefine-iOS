//
//  Networking.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 10/3/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol Networking {
    func searchRequest(_ searchTerm: String) -> Observable<(HTTPURLResponse, Any)>
}
