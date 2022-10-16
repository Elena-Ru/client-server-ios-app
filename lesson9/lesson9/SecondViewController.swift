//
//  SecondViewController.swift
//  lesson9
//
//  Created by Елена Русских on 14.10.2022.
//

import UIKit

class SecondViewController: UIViewController {

    let service = Service()
    var users = [String]()
    var userId = UserDefaults.standard.string(forKey: "userId")
    var colors = ["white", "black", "green", "blue", "pink"]
    var userColors = [String]()
    
    @IBOutlet weak var colorsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorsTable.dataSource = self
        self.colorsTable.delegate = self   
        
        service.getAllUsers { items in
            self.users = items
            print(self.users)
        }
        
        service.getAlluserColors(userId: userId!) { items in
            self.userColors = items
            print(self.userColors)
            self.colorsTable.reloadData()
        }
       
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        service.logOut { isLogOut in
            if isLogOut {
                self.dismiss(animated: true)
            }
        }
    }
    
}


extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            service.saveUserColors(userId: userId!, color: colors[indexPath.row])
          
            service.getAlluserColors(userId: userId!) { items in
                self.userColors = items
                print(self.userColors)
                tableView.reloadData()
            }
            }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return colors.count
        } else {
            return  userColors.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorTableViewCell
        var color = ""
        
        if indexPath.section == 0{
             color = colors[indexPath.row]
        } else {
             color = userColors[indexPath.row]
        }
        
        cell.color.text = color
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .systemCyan
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)

        if section == 0 {
            label.text = "Pick up your favorite colors"
        } else {
            label.text = "Your choice is:"
        }
        headerView.addSubview(label)
        return headerView
    }
    
    
}
