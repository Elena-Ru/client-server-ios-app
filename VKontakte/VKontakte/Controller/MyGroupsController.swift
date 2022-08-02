//
//  MyGroupsController.swift
//  VKontakte
//
//  Created by Елена Русских on 20.06.2022.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    var groups = [Group]()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
       
        if segue.identifier == "addGroup" {
        let allGroupsController = segue.source as! AllGroupsController
        if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
            let group : Group
            if allGroupsController.isFiltering(){
                 group = allGroupsController.currentGroup} else{
                     group = allGroupsController.groups[indexPath.row]
                }
            
            if !groups.contains(where: {$0.name == group.name}){
            groups.append(group)
            tableView.reloadData()
        }
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsCell
        

        let group = groups[indexPath.row].name
        let image = groups[indexPath.row].image
        
        cell.groupName.text = group
        cell.groupImage.image = image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
}
