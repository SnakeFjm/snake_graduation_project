//
//  BaseSearchViewController.swift
//  FoodDetect
//
//  Created by dev on 2017/12/19.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit
import MJRefresh
import SwiftyJSON

class BaseSearchViewController: RefreshTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController: UISearchController!

    var searchContent: String!
    
    // =================================
    // MARK:
    // =================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        self.needShowEmptyViewWhenNoneData = false
        
        //
        self.initSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        if self.searchController != nil {
            self.searchController.isActive = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSearchController() {
        //
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "搜索"
        
        //
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
    
    
    func currentSearchContent() -> String? {
        let content = self.searchController.searchBar.text
        if content == nil {
            return nil
        }
        let trimString = content?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimString
    }
    
    // =================================
    // MARK:
    // =================================
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 每次搜索，要重置加载状态
        self.resetRefreshStatus()
        //
        self.dataArray = []
        self.reloadTableViewData()
        //
        self.searchContent = self.currentSearchContent()
        //
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        //
        if self.searchController != nil {
            self.searchController.isActive = false
        }
    }
    
    
    
}
