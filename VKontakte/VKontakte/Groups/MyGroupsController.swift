//
//  MyGroupsController.swift
//  VKontakte
//
//  Created by Елена Русских on 20.06.2022.
//

import UIKit
import SDWebImage
import RealmSwift

class MyGroupsController: UITableViewController {
    
    let apiManager = APIManager()
    let session = Session.shared
    
    var groupsReq = [Group]() // for request
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
       
        if segue.identifier == "addGroup" {
        let allGroupsController = segue.source as! AllGroupsController
        if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
            let group : Group
            if allGroupsController.isFiltering(){
                group = allGroupsController.filteredGroups[indexPath.row]
                } else{
                     group = allGroupsController.groups[indexPath.row]
                }

            if !groupsReq.contains(where: {$0.name == group.name}){
            groupsReq.append(group)
            tableView.reloadData()
        }
        }
        }
    }

    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var mainUser = realm.objects(MainUser.self)
        
        if (mainUser.first?.groups.count)! > 0 {
            
            self.groupsReq = Array(mainUser.first!.groups)
            self.tableView.reloadData()
            
        } else {
            
            apiManager.getUserGroups(token: session.token, id: session.userID){ [weak self] items  in
                
                self?.groupsReq = items
                
                do{
                    
                    self?.realm.beginWrite()
                    var mainUser = self?.realm.objects(MainUser.self).first
                    mainUser?.groups.append(objectsIn: items)
                    
                    for i in 0 ..< ((self?.groupsReq.count)!){
                        self?.groupsReq[i].owner = mainUser
                    }
                    
                    try self?.realm.commitWrite()
                }catch{
                    print(error)
                }
                
                self?.tableView.reloadData()
                
            }
        } //end else
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsReq.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsCell
        

        let group = groupsReq[indexPath.row].name
        
        let url = URL(string: groupsReq[indexPath.row].photoGroup)
        cell.groupImage.sd_setImage(with: url)
        
        cell.groupName.text = group


        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsReq.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
}
