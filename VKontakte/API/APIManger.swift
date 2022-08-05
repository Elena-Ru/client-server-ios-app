//
//  APIManger.swift
//  VKontakte
//
//  Created by Елена Русских on 04.08.2022.
//

import Foundation
import Alamofire


class APIManager{
    
    let baseUrl = "https://api.vk.com"
    let clientId = "8233581" //id_приложения
 
    
    func getFriendsList(token: String, id: Int){
        
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "order": "name", // сортировка по имени
            "v": "5.131"
        ]
        
        let url = baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            print("********FRIENDS***********")
            print(response.value as Any)
        }
    }
    
    
    func getUserPhotos(token: String, id: Int){
        
        let path = "/method/photos.getAll"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, parameters: parameters).responseJSON { response in
            print("********PHOTOS***********")
            print(response.value as Any)
        }
    }
    
    func getUserGroups(token: String, id: Int){
        
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, parameters: parameters).responseJSON { response in
            print("*******GROUPS************")
            print(response.value as Any)
        }
    }
    
    func getUserGroupsSearch(token: String){
        
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "q": "running",
            "type": "group",
            "count": "2",
            "sort": 6,
            "access_token" : token,
            "client_id": clientId,
            "v": "5.131"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, parameters: parameters).responseJSON { response in
            print("*******GROUPS-Search************")
            print(response.value as Any)
        }
    }
    
}
