//
//  SearchViewController.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 12/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import UIKit
import RxSwift

/**
 ViewController which enables a user to search a term, locally store it in the table,
 and display a defintion of it
 */
class SearchViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchPresenter: SearchPresenter? // DI
    
    fileprivate var tableDataStore: SearchTableDataStore? // Table data store

    // Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPresenter?.attachView(self)
        
        initVC()
    }
    
    // Lifecycle method
    deinit {
        searchPresenter?.detachView()
    }
    
    /**
     Initialise ViewController properties/functionality
     */
    private func initVC() {
        tableDataStore = SearchTableDataStore(self)

        tableView.delegate = tableDataStore
        tableView.dataSource = tableDataStore
        
        searchPresenter?.loadLastSearchTerm()
    }
    
    /**
     Save search term to table data store and via presenter
     */
    fileprivate func saveSearchTerm(_ term: String) {
        if (self.tableDataStore?.getItems().contains(term))! {
            return
        }

        self.tableDataStore?.insertItem(term, tableView)
        searchPresenter?.saveLastSearchTerm(term)
    }
    
    /**
     Perform search for a term
     */
    func performSearchForTerm(_ term: String?) {
        guard let term = term else { return }
        
        searchPresenter?.performSearch(term)
    }
    
    /**
     Show an error alert message
     */
    fileprivate func showErrorAlertMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     Show an alert for no defintion found
     */
    fileprivate func showNoDefinitionAlertForTerm(_ term: String) {
        let alertController = UIAlertController(title: "Huh...", message: "No definition could be found for \(term). Try searching for something else?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     Segue preparation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let context = sender as? SearchDefinitionSegueContext, segue.identifier == "SearchDefinitionSegue" {
            let vc = segue.destination as! DefinitionViewController
            vc.definition = context.definition
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    /**
     Search button clicked. Perform search
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        performSearchForTerm(searchBar.text)
    }
}

////////////////////////////////////////////////////////////////////////////////////
///////////////////  ========== MVP INTERFACE METHODS ========== ///////////////////
////////////////////////////////////////////////////////////////////////////////////

extension SearchViewController : SearchMvpView {
    /**
     Display activity indicator while search in progress
     */
    func showSearchInProgress() {
        self.activityIndicator.startAnimating()
    }
    
    /**
     Save search term if matching definition returned, and perform segue to DefinitionViewController
     */
    func showSearchDefinition(_ term: String, _ definition: SearchDefinition) {
        self.activityIndicator.stopAnimating()
        
        if StringUtils.isNullOrEmpty(definition.heading)
            || StringUtils.isNullOrEmpty(definition.abstractText) {
            self.showNoDefinitionAlertForTerm(term)
            return
        }
        
        self.saveSearchTerm(term)
        self.performSegue(withIdentifier: "SearchDefinitionSegue", sender: SearchDefinitionSegueContext(definition: definition))
    }

    /**
     Display last search term in search bar
     */
    func displayLastSearchTerm(_ term: String) {
        self.searchBar.text = term
    }
    
    /**
     Handle error results
     */
    func handleErrorResult(_ errorMessage: String) {
        self.activityIndicator.stopAnimating()
        self.showErrorAlertMessage(errorMessage)
        self.showNoDefinitionAlertForTerm(searchBar.text!)
    }
}
