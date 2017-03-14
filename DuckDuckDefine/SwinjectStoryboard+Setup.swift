//
//  SwinjectStoryboard.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 10/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import SwinjectStoryboard

/**
 Initialise Dependency Injection graph for various classes
 */
extension SwinjectStoryboard {
    class func setup() {
        // MARK: - View Controller's
        defaultContainer.storyboardInitCompleted(SearchViewController.self) { r, c in
            c.searchPresenter = r.resolve(SearchPresenter.self)
        }
        
        // MARK: - Presenters
        defaultContainer.register(SearchPresenter.self) { r in
            SearchPresenter(dataManager: r.resolve(DataManager.self)!)
        }
        
        // MARK: - Business Logic Layer's
        defaultContainer.register(DataManager.self) { r in
            DataManager(duckDuckGoApiService: r.resolve(DuckDuckGoApiService.self)!, userDefaultsHelper: UserDefaultsHelper())
        }

        defaultContainer.register(DuckDuckGoApiService.self, factory: { _ in DuckDuckGoApiHandler()} )
    }
}
