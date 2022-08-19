//
//  AllFriendsViewController.swift
//  VKontakte
//
//  Created by Елена Русских on 29.06.2022.
//

import UIKit
import SDWebImage
import WebKit

class AllFriendsViewController: UIViewController {
    
    
    @IBOutlet weak var friendsTable: UITableView!
    
    let session = Session.shared
    let apiManager = APIManager()
    var mainUser = [MainUser]() //для запроса данных пользователя
    var friendsList = [User]() // для запроса списка друзей
    let nName = Notification.Name("logout")

    @IBAction func logOut(_ sender: UIButton) {
        resetWK()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsTable.dataSource = self
        friendsTable.delegate = self
        
        apiManager.getUserInfo(token: session.token, id: session.userID) { [weak self] response in
            self?.mainUser = response
            self!.session.userName = (self?.mainUser[0].firstName)!
            self!.navigationItem.title = "Пользователь "+self!.session.userName
        }
        
        apiManager.getFriendsList(token: session.token, id: session.userID){ [weak self] items  in
            self?.friendsList = items
            self?.friendsTable?.reloadData()
        }
        print("_____________________________")
        print("_____________________________")
        apiManager.readRealm(self.friendsList)
        print("_____________________________")
        print("_____________________________")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        friendsTable.backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 36/255, alpha: 1)
    }
    
    func resetWK(){
        
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date(timeIntervalSince1970: 0)) {
            
            self.session.token = ""
            NotificationCenter.default.post(name: self.nName, object: nil)
        }
    }
}

extension AllFriendsViewController: UITableViewDelegate, UITableViewDataSource{
    
     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return friendsList.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell", for: indexPath) as! AllFriendsTableViewCell
     
         let name = friendsList[indexPath.row].fullName

         UIView.animate(withDuration: 0.5, animations: {
             cell.FriendName.frame.origin.y -= 100
         })
    
        cell.FriendName.text = name
         cell.backgroundColor = UIColor.clear
         cell.FriendName.textColor = UIColor.white

        for subView in cell.AvatarShadow.subviews{
            if subView is UIImageView{
                let imageView = subView as! UIImageView
                
                let url = URL(string: friendsList[indexPath.row].photo100)
                imageView.sd_setImage(with: url)
            }
        }
         
        return cell
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPhoto",
            let destinationVC = segue.destination as? PhotoViewController,
           let indexPath = friendsTable.indexPathForSelectedRow {
            destinationVC.title = friendsList[indexPath.row].firstName
            destinationVC.friendID = friendsList[indexPath.row].id // передаем ID для запроса фото пользователя
            destinationVC.friend = friendsList[indexPath.row]
        }
    }
    
}
