//
//  UserDefaultsHelper.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 14/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation

/**
 Access instance of UserDefaults to get and update keys
 */
struct UserDefaultsHelper {
    private let userDefaults = UserDefaults.standard

    // User defaults keys
    private enum Keys {
        static let lastSearch = "KEY_LAST_SEARCH"
    }

    /**
     Return saved last search value
     */
    func getLastSearch() -> String {
        let value = userDefaults.string(forKey: Keys.lastSearch) ?? ""
        return value
    }
    
    /**
     Save last search value
     */
    func setLastSearch(term: String) {
        userDefaults.set(term, forKey: Keys.lastSearch)
    }
}
