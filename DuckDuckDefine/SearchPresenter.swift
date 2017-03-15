//
//  SearchPresenter.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 12/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Alamofire

/**
 Protocol to connect the following classes: SearchViewController and SearchPresenter
 */
protocol SearchMvpView: MvpView {
    func showSearchInProgress()
    func showSearchDefinition(_ term: String, _ definition: SearchDefinition)
    func displayLastSearchTerm(_ term: String)
    func handleErrorResult(_ errorMessage: String)
}

/**
 Presenter that handles business logic for SearchViewController
 */
final class SearchPresenter: BasePresenter<SearchMvpView> {
    private let dataManager: DataManager
    
    init(dataManager : DataManager) {
        self.dataManager = dataManager
    }
    
    /**
     Perform search based on param
     */
    func performSearch(_ term : String) -> () {
        dataManager.getSearchResults(term)
            .observeOn(MainScheduler.instance)
            .do(onSubscribe: { [weak self] in
                self?.getMvpView().showSearchInProgress()
            })
            .subscribe(
                onNext: { [weak self] (resultTuple: (HTTPURLResponse, SearchDefinition)) in
                    if (self?.isHttpErrorPresent(resultTuple.0))!{
                        return
                    }

                    self?.getMvpView().showSearchDefinition(term, resultTuple.1)
                },
                
                onError: { [weak self] (error) in
                    self?.handleRequestError(error as NSError)
                },
                
                onCompleted: {
                    // Not used
            })
            .addDisposableTo(getDisposeBag())
    }
    
    /**
     Load last search term and display on UI
     */
    func loadLastSearchTerm() -> () {
        getMvpView().displayLastSearchTerm(dataManager.getLastSearchTerm())
    }
    
    /**
     Save last search term
     */
    func saveLastSearchTerm(_ term: String) -> () {
        dataManager.setLastSearchTerm(term)
    }

    /**
     Handle non-HTTP errors gracefully
     */
    private func handleRequestError(_ error: NSError) {
        if (error.code == NSURLErrorNotConnectedToInternet) {
            let errorMessage = "Not connected to the internet"
            getMvpView().handleErrorResult(errorMessage)
        }
        
        if (error.code == NSURLErrorSecureConnectionFailed) {
            let errorMessage = "SSL Authentication error"
            getMvpView().handleErrorResult(errorMessage)
        }
    }
    
    /**
     Handle HTTP errors gracefully
     */
    private func isHttpErrorPresent(_ response: HTTPURLResponse) -> Bool {
        if response.statusCode < 200 || response.statusCode >= 300 {
            let errorMessage = "HTTP \(response.statusCode) error"
            getMvpView().handleErrorResult(errorMessage)

            return true
        }
        
        return false
    }
}
