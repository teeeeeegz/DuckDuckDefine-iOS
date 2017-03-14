//
//  SearchTableDataStore.swift
//  DuckDuckDefine
//
//  Created by Michael Tigas on 13/3/17.
//  Copyright © 2017 Michael Tigas. All rights reserved.
//

import UIKit

/**
 This data store handles UITableView functionality, including inserting of items, binding items to cells,
 and row selection
 */
class SearchTableDataStore: NSObject {
    fileprivate weak var viewController: SearchViewController?

    fileprivate var items: [String] = []
    
    init(_ viewController: SearchViewController) {
        self.viewController = viewController;
    }
    
    /**
     Return data store list
     */
    func getItems() -> [String] {
        return items
    }
    
    /**
     Add an item to the data store
     */
    func insertItem(_ item: String, _ tableView: UITableView) -> () {
        items.insert(item, at: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension SearchTableDataStore: UITableViewDataSource {
    /**
     Bind data to a cell. Manage cell recycling here
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableViewDelegate
extension SearchTableDataStore: UITableViewDelegate {
    /**
     Display a blank view as the footer of the UITableView, to prevent multiple 
     row dividers being drawn
     */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    /**
     Peform search for respective tapped row tap
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = viewController {
            viewController.performSearchForTerm(items[indexPath.row])
        }
    }
}
