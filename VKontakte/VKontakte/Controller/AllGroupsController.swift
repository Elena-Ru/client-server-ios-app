//
//  AllGroupsController.swift
//  VKontakte
//
//  Created by Елена Русских on 20.06.2022.
//

import UIKit

class AllGroupsController: UITableViewController, UISearchBarDelegate {
    
    var groups = [
    Group(name: "Healthy Meal", image: UIImage(named: "group1.jpeg")!),
    Group(name: "Recipes", image: UIImage(named: "group2.jpeg")!),
    Group(name: "Running", image: UIImage(named: "group3.jpeg")!),
    Group(name: "IOS developers", image: UIImage(named: "group4.jpeg")!),
    Group(name: "Batman Fan Club", image: UIImage(named: "group5.jpeg")!),
    Group(name: "Trip", image: UIImage(named: "group6.jpeg")!)
    ]
    
//массив с отфильтрованныи группами
    var filteredGroups = [Group]()
    
    var currentGroup : Group = Group(name: "Healthy Meal", image: UIImage(named: "group1.jpeg")!)
    
   lazy var searchController: UISearchController = {
     let  search = UISearchController(searchResultsController: nil)
       search.searchResultsUpdater = self
        
       search.obscuresBackgroundDuringPresentation = false
       search.searchBar.placeholder = "Search group"
       search.searchBar.sizeToFit()
       search.searchBar.searchBarStyle = .prominent
       search.searchBar.delegate = self
        
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
       // tableView.isUserInteractionEnabled = true
       
        navigationItem.searchController = searchController

    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredGroups.count
        }
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! AllGroupsCell
        
        if isFiltering(){
            self.currentGroup = filteredGroups[indexPath.row]
        } else{
            self.currentGroup = groups[indexPath.row]
        }

        let group = self.currentGroup.name
        let image = self.currentGroup.image
        
        cell.GroupName.text = group
        cell.GroupImage.image = image

        return cell
    }
    
    
    
    
    func filterGroupsForSearchText (searchText: String/*, scope:String = "All"*/){
        filteredGroups = groups.filter({$0.name.lowercased().contains(searchText.lowercased())})
        tableView.reloadData()
    }
    
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    func searchBar(_ searchBar: UISearchBar/*, selectedScopeButtonIndexDidChange selectedScope: Int*/) {
        
        filterGroupsForSearchText(searchText: searchBar.text!)
    }
    
    
    func isFiltering() -> Bool{
        
        return searchController.isActive && /*(*/!isSearchBarEmpty() /*|| searchBarScopeIsFiltering)*/
    }
}



extension AllGroupsController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterGroupsForSearchText(searchText: searchBar.text!)
    }
}
