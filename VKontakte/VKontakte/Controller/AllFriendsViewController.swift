//
//  AllFriendsViewController.swift
//  VKontakte
//
//  Created by Елена Русских on 29.06.2022.
//

import UIKit

class AllFriendsViewController: UIViewController {
    
    
    @IBOutlet weak var friendsNameControl: FriendsNamesControl!
    
    @IBOutlet weak var friendsTable: UITableView!
    
        var friends = [
        User(name: "Ivan", image: [PhotoUser(image: UIImage(named: "friend1.jpeg")! ), PhotoUser(image: UIImage(named: "friend1_1.jpeg")! )]),
        User(name: "Oleg", image: [PhotoUser(image: UIImage(named: "friend2.jpeg")! )]),
        User(name: "Katya", image: [PhotoUser(image: UIImage(named: "friend3.jpeg")! ), PhotoUser(image: UIImage(named: "friend3_1.jpeg")!), PhotoUser(image: UIImage(named: "friend3_2.jpeg")!)]),
        User(name: "Olya", image: [PhotoUser(image: UIImage(named: "friend4.jpeg")! )]),
       User(name: "Sergey", image: [PhotoUser(image: UIImage(named: "friend5.jpeg")! )]),
        User(name: "Victoria", image: [PhotoUser(image: UIImage(named: "friend6.jpeg")! )]),
        User(name: "Anastasia", image: [PhotoUser(image: UIImage(named: "friend7.jpeg")!), PhotoUser(image: UIImage(named: "friend8.jpeg")!), PhotoUser(image: UIImage(named: "friend9.jpeg")!), PhotoUser(image: UIImage(named: "friend10.jpeg")! )])
//        User(name: "Vasiliy", image: UIImage(named: "friend8.jpeg")!),
//        User(name: "Nina", image: UIImage(named: "friend9.jpeg")!),
//        User(name: "Anna", image: UIImage(named: "friend10.jpeg")!)
    ]
   
   var firstLetterOfTheName = [Character]()

   var filterFriends = [User]()
    
   var structuredFriends: [Int: [User]] = [:]

    //запускается 1 раз
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsTable.dataSource = self
        friendsTable.delegate = self
        setFirstLettersArray()
        self.friendsNameControl.setFriendsNamesControl(controller:self)
        tabBarItem.title = "Friends"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        friendsTable.backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 36/255, alpha: 1)
        
    }
}

extension AllFriendsViewController: UITableViewDelegate, UITableViewDataSource{
    

    
    func setFirstLettersArray (){
        for i in 0..<friends.count {
            guard !firstLetterOfTheName.contains(friends[i].name.first!) else {
                continue
            }
            firstLetterOfTheName.append(friends[i].name.first!)
        }
        firstLetterOfTheName = firstLetterOfTheName.sorted()
    }

    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let label = UILabel()
         label.text = String(firstLetterOfTheName[section])
         label.textColor = UIColor.white
         label.backgroundColor = UIColor(red: 57/255, green: 47/255, blue: 68/255, alpha: 0.5)
         return label
    }

     func numberOfSections(in tableView: UITableView) -> Int {

        return firstLetterOfTheName.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.filter({ $0.name.first?.lowercased() == firstLetterOfTheName[section].lowercased() }).count

    }
     func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        filterFriends = friends.filter({
            $0.name.first?.lowercased() == firstLetterOfTheName[indexPath.section].lowercased()})
        structuredFriends[indexPath.section] =  filterFriends
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell", for: indexPath) as! AllFriendsTableViewCell
        let image = filterFriends[indexPath.row].image
        let name = filterFriends[indexPath.row].name
   
         UIView.animate(withDuration: 0.5, animations: {
             cell.FriendName.frame.origin.y -= 100
         })
    
        cell.FriendName.text = name
         cell.backgroundColor = UIColor.clear
         cell.FriendName.textColor = UIColor.white

        for subView in cell.AvatarShadow.subviews{
            if subView is UIImageView{
                let imageView = subView as! UIImageView
                imageView.image = image[0].photo
            }
        }
         
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPhoto",
           let destinationVC = segue.destination as? PhotoViewController,
           let indexPath = friendsTable.indexPathForSelectedRow {
            
            let section = structuredFriends[indexPath.section]
            let friendName = section?[indexPath.row].name
            let photo = section?[indexPath.row].image
            destinationVC.title = friendName
            destinationVC.friendPhoto = photo!
            destinationVC.friend = section?[indexPath.row]
        }
    }
    
}
