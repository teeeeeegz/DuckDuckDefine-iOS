//
//  DataManager.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 13/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation
import RxSwift

/**
 Responsible for handling business logic between various services: Network, Storage etc.
 */
struct DataManager {
    private let duckDuckGoApiService: DuckDuckGoApiService
    private let userDefaultsHelper: UserDefaultsHelper
    
    init(duckDuckGoApiService: DuckDuckGoApiService,
         userDefaultsHelper: UserDefaultsHelper) {
        self.duckDuckGoApiService = duckDuckGoApiService
        self.userDefaultsHelper = userDefaultsHelper
    }

    ////////////////////////////////////////////////////////////////////////////////////
    //////////////  ========== UserDefaultsHelper ONLY METHODS ========== //////////////
    ////////////////////////////////////////////////////////////////////////////////////

    /**
     Return the last search term
     */
    func getLastSearchTerm() -> String {
        return userDefaultsHelper.getLastSearch()
    }

    /**
     Update the last search term
     */
    func setLastSearchTerm(_ term: String) {
        userDefaultsHelper.setLastSearch(term: term)
    }

    ////////////////////////////////////////////////////////////////////////////////////
    /////////////  ========== DuckDuckGoApiService ONLY METHODS ========== /////////////
    ////////////////////////////////////////////////////////////////////////////////////
    
    /**
     Send a search term request to get a SearchDefinition response
     */
    func getSearchResults(_ searchTerm: String) -> Observable<(HTTPURLResponse, SearchDefinition)> {
        // Build param list
        let parameters: [String:AnyObject] = ["q": searchTerm as AnyObject,
                                              "format": "json" as AnyObject,
                                              "pretty": 1 as AnyObject,
                                              "no_html": 1 as AnyObject,
                                              "skip_disambig": 1 as AnyObject]
        
        return duckDuckGoApiService.searchRequest(parameters)
    }
}
