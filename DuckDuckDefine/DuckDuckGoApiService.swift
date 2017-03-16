//
//  DuckDuckGoApiService.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 10/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxAlamofire
import RxSwift

/**
 DuckDuckGo API protocol
 */
protocol DuckDuckGoApiService {
    func searchRequest(_ parameters: [String:AnyObject]) -> Observable<(HTTPURLResponse, SearchDefinition)>
}

/**
 Handle all DuckDuckGo API endpoints
 */
struct DuckDuckGoApiHandler : DuckDuckGoApiService {
    let sourceUrl = "https://api.duckduckgo.com"
    
    /**
     Send a search request to DuckDuckGo with params. Parse response into a SearchDefinition
     object and return it as part of a tuple with the HTTPURLResponse
     */
    func searchRequest(_ parameters: [String:AnyObject])
        -> Observable<(HTTPURLResponse, SearchDefinition)> {

        return RxAlamofire.requestJSON(.get, sourceUrl, parameters: parameters)
            .debug()
            .map({ (response: HTTPURLResponse, json: Any) -> (HTTPURLResponse, SearchDefinition) in
                let responseJson = JSON(json)
                
                return (response, SearchDefinition.init(json: responseJson.dictionaryObject!)!)
            })
    }
}
