//
//  Service.swift
//  lesson9
//
//  Created by Елена Русских on 14.10.2022.
//

import Foundation
import Firebase

class Service{
    
    func regNewUser(_ email: String, _ password: String, completion: @escaping (Bool) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                if let res = result {
                    res.user.sendEmailVerification()
                    self.saveUserData(userId: res.user.uid, email: email)
                    print(res.user.uid)
                    UserDefaults.standard.set(res.user.uid, forKey: "userId")
                    completion(true)
                }
            } else {
                let error = error as? NSError
                switch error!.code {
                    
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    completion(false)
                default:
                    completion(true)
                }
            }
        }
    }
    
    func saveUserData(userId: String, email: String){
        let UserData: [String: Any] = [
            "email": email,
            "name": "Vasya",
        ]
        Firestore.firestore().collection("users")
            .document(userId)
            .setData(UserData)
    }
    
    func saveUserColors(userId: String, color: String){

        getAlluserColors(userId: userId) { items in
            
            if items.firstIndex(of: color) == nil {
                Firestore.firestore().collection("users").document(userId).collection("colors").document(color)
                    .setData(["color": color])
            }
        }
    }
    
    func getAlluserColors(userId: String, completion: @escaping ([String]) -> ()){

        Firestore.firestore().collection("users").document(userId).collection("colors")
            .addSnapshotListener { snap, err in
                if err == nil {
                    var colors = [String]()
                    if let docs = snap?.documents{
                        for doc in docs{
                            let name = doc["color"] as! String
                            colors.append(name)
                        }
                        completion(colors)
                    }
                }
            }
    }
    
    func signIn(_ email: String, _ password: String, completion: @escaping (Bool) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { res, error in
            if error == nil {
                if let res = res {
                    if res.user.isEmailVerified {
                        print(res.user.uid)
                        UserDefaults.standard.set(res.user.uid, forKey: "userId")
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
               
            } else {
                completion(false)
            }
        }
    }
    
    func getAllUsers(completion: @escaping ([String]) -> ()){
        
        Firestore.firestore().collection("users")
            .getDocuments { snap, err in
                if err == nil {
                    var users = [String]()
                    if let docs = snap?.documents{
                        for doc in docs{
                            let name = doc["name"] as! String
                            users.append(name)
                        }
                        completion(users)
                    }
                }
            }
    }
    
    func logOut(completion: @escaping (Bool) -> ()){
        
        do{
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
           // UserDefaults.standard.set("", forKey: "userId")
            completion(true)
        }
        catch {
            print(error)
            completion(false)
        }
        
    }
}
